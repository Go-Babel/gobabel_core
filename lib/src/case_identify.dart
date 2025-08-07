// | Name            | Example                     |
// | --------------- | --------------------------- |
// | `importCase`    | `package:dartz/dartz.dart`  |
// | `camelCase`     | `helloWorld`                |
// | `constantCase`  | `HELLO_WORLD`               |
// | `dotCase`       | `hello.world`               |
// | `headerCase`    | `Hello-World`               |
// | `lowerCase`     | `hello world`               |
// | `mustacheCase`  | `{{ Hello World }}`         |
// | `pascalCase`    | `HelloWorld`                |
// | `pascalDotCase` | `Hello.World`               |
// | `paramCase`     | `hello-world`               |
// | `pathCase`      | `hello/world`               |
// | `sentenceCase`  | `Hello world`               |
// | `snakeCase`     | `hello_world`               |
// | `titleCase`     | `Hello World`               |
// | `upperCase`     | `HELLO WORLD`               | (?<!\w)\w{1,}(?:\/\w+){1,}\/?(?:.\w{1,}){0,}(?!\w)

class CaseIdentifyRegex {
  // If you wan't without end suffix optional (ex: .dart), use: (?<!\w)\w{1,}(?:\/\w+){1,}\/?(?!\w)

  static const String importCase = r'^\w+:(?:[\w/\.]+)$';
  static const String numberCase = r'^\d+$';
  static const String pathCase = r'^(?:'
      r'[\/]$|' // Just /
      r'[\/][\w-]+(?:\.[\w]+)?[\/]?|' // /splash, /splash.dart, /splash.dart/
      r'[\/][\w-]+(?:[\/][\w-]+)*(?:\.[\w]+)?[\/]?|' // /home/user/documents
      r'[\w-]+(?:[\/][\w-]+)+(?:\.[\w]+)?[\/]?|' // hello/world, path/to/file.dart
      r'(?:[A-Za-z]:[\\](?:[\w\s-]+[\\])*[\w\s-]+[\\]?|[\\][\w\s-]+(?:[\\][\w\s-]+)*[\\]?|[\w\s-]+[\\][\w\s-]+(?:[\\][\w\s-]+)*[\\]?)' // Windows paths
      r')$';
  static const String camelCase = r'^[a-z][a-z0-9]*([A-Z][a-zA-Z0-9]*)+$';
  static const String constantCase =
      r'^(?<!\w)[A-Z0-9]{1,}(?:_[A-Z0-9]+){1,}(?!\w)$';
  static const String dotCase =
      r'^(?<!\w)[a-z0-9]{1,}(?:\.[a-z0-9]+){1,}(?!\w)$';
  static const String headerCase = r'^[A-Z][a-z0-9]*(-[A-Z][a-z0-9]*)+$';
  static const String pascalDotCase =
      r'^[A-Z][a-zA-Z0-9]*(?:\.[A-Z][a-zA-Z0-9]*)+$';
  static const String pascalCase = r'^([A-Z][a-zA-Z0-9]*){2,}$';
  static const String paramCase =
      r'^(?<!\w)[a-z0-9]{1,}(?:-[a-z0-9]+){1,}(?!\w)$';
  static const String snakeCase =
      r'^(?<!\w)[a-z0-9]{1,}(?:_[a-z0-9]+){1,}(?!\w)$';

  /// The FULL TEXT should be in the case you want to identify.
  static bool isCase(String value, String regex) {
    if (value.isEmpty) return false;
    if (!RegExp(r'[a-zA-Z]').hasMatch(value)) return false;

    final regExp = RegExp(regex, multiLine: true);
    final matches = regExp.allMatches(value);
    if (matches.isEmpty) return false;
    if (matches.length > 1) return false;
    return matches.first.start == 0 && matches.first.end == value.length;
  }

  static bool isImportCase(String value) => isCase(value, importCase);
  static bool isPathCase(String value) => isCase(value, pathCase);
  static bool isCamelCase(String value) => isCase(value, camelCase);
  static bool isConstantCase(String value) => isCase(value, constantCase);
  static bool isDotCase(String value) => isCase(value, dotCase);
  static bool isHeaderCase(String value) => isCase(value, headerCase);
  static bool isPascalDotCase(String value) => isCase(value, pascalDotCase);
  static bool isPascalCase(String value) => isCase(value, pascalCase);
  static bool isParamCase(String value) => isCase(value, paramCase);
  static bool isSnakeCase(String value) => isCase(value, snakeCase);
  static bool isOnlyNumber(String value) => isCase(value, numberCase);

  /// Detects if a string contains base64 encoded content.
  /// This includes PEM format certificates, keys, and other base64 data.
  static bool containsBase64(String value) {
    // Check for PEM format markers (certificates, keys)
    final pemMarkers = [
      '-----BEGIN CERTIFICATE-----',
      '-----END CERTIFICATE-----',
      '-----BEGIN PRIVATE KEY-----',
      '-----END PRIVATE KEY-----',
      '-----BEGIN PUBLIC KEY-----',
      '-----END PUBLIC KEY-----',
      '-----BEGIN RSA PRIVATE KEY-----',
      '-----END RSA PRIVATE KEY-----',
      '-----BEGIN EC PRIVATE KEY-----',
      '-----END EC PRIVATE KEY-----',
    ];

    for (final marker in pemMarkers) {
      if (value.contains(marker)) {
        return true;
      }
    }

    // Check for continuous base64 sequences
    // Base64 uses A-Z, a-z, 0-9, +, /, and = for padding
    // Look for sequences of at least 40 characters that look like base64
    final base64Pattern = RegExp(r'[A-Za-z0-9+/]{40,}={0,2}');

    if (base64Pattern.hasMatch(value)) {
      // Additional check: if we found a long base64-like sequence,
      // verify it's not just a normal word by checking character distribution
      final match = base64Pattern.firstMatch(value)!.group(0)!;

      // Count different character types
      final upperCount = RegExp(r'[A-Z]').allMatches(match).length;
      final lowerCount = RegExp(r'[a-z]').allMatches(match).length;
      final digitCount = RegExp(r'[0-9]').allMatches(match).length;
      final specialCount = RegExp(r'[+/]').allMatches(match).length;

      // Base64 typically has a good mix of upper, lower, and digits
      // If it's mostly one type, it's probably not base64
      final total = match.length;
      final maxRatio = [
        upperCount,
        lowerCount,
        digitCount,
      ].map((c) => c / total).reduce((a, b) => a > b ? a : b);

      // If any character type dominates (>70%), it's probably not base64
      // Also check if it has at least some digits or special chars
      if (maxRatio < 0.7 && (digitCount > 0 || specialCount > 0)) {
        return true;
      }
    }

    return false;
  }

  /// Detects if a string contains SHA1 hash/key (40 hex characters).
  static bool containsSha1Key(String value) {
    // SHA1 produces 160 bits = 20 bytes = 40 hex characters
    // Look for sequences of exactly 40 hex characters
    // Common patterns: standalone, with prefix like "sha1:", in quotes, etc.
    final sha1Pattern = RegExp(
      r'(?:^|[^a-fA-F0-9])([a-fA-F0-9]{40})(?:[^a-fA-F0-9]|$)',
      caseSensitive: false,
    );

    if (sha1Pattern.hasMatch(value)) {
      // Additional check: if it's all the same character, it's probably not a real hash
      final match = sha1Pattern.firstMatch(value)!.group(1)!;
      final firstChar = match[0];
      if (!match.split('').every((c) => c == firstChar)) {
        return true;
      }
    }

    return false;
  }

  /// Detects if a string contains SHA2 family hash/key.
  /// SHA2 includes SHA224 (56 hex), SHA256 (64 hex), SHA384 (96 hex), SHA512 (128 hex).
  static bool containsSha2Key(String value) {
    // Check for any SHA2 variant
    return containsSha256Key(value) ||
        containsSha512Key(value) ||
        _containsSha224Key(value) ||
        _containsSha384Key(value);
  }

  // Helper for SHA224 (56 hex chars)
  static bool _containsSha224Key(String value) {
    final sha224Pattern = RegExp(
      r'(?:^|[^a-fA-F0-9])([a-fA-F0-9]{56})(?:[^a-fA-F0-9]|$)',
      caseSensitive: false,
    );

    if (sha224Pattern.hasMatch(value)) {
      final match = sha224Pattern.firstMatch(value)!.group(1)!;
      final firstChar = match[0];
      if (!match.split('').every((c) => c == firstChar)) {
        return true;
      }
    }
    return false;
  }

  // Helper for SHA384 (96 hex chars)
  static bool _containsSha384Key(String value) {
    final sha384Pattern = RegExp(
      r'(?:^|[^a-fA-F0-9])([a-fA-F0-9]{96})(?:[^a-fA-F0-9]|$)',
      caseSensitive: false,
    );

    if (sha384Pattern.hasMatch(value)) {
      final match = sha384Pattern.firstMatch(value)!.group(1)!;
      final firstChar = match[0];
      if (!match.split('').every((c) => c == firstChar)) {
        return true;
      }
    }
    return false;
  }

  /// Detects if a string contains SHA256 hash/key (64 hex characters).
  static bool containsSha256Key(String value) {
    // SHA256 produces 256 bits = 32 bytes = 64 hex characters
    final sha256Pattern = RegExp(
      r'(?:^|[^a-fA-F0-9])([a-fA-F0-9]{64})(?:[^a-fA-F0-9]|$)',
      caseSensitive: false,
    );

    if (sha256Pattern.hasMatch(value)) {
      final match = sha256Pattern.firstMatch(value)!.group(1)!;
      final firstChar = match[0];
      if (!match.split('').every((c) => c == firstChar)) {
        return true;
      }
    }

    return false;
  }

  /// Detects if a string contains SHA512 hash/key (128 hex characters).
  static bool containsSha512Key(String value) {
    // SHA512 produces 512 bits = 64 bytes = 128 hex characters
    final sha512Pattern = RegExp(
      r'(?:^|[^a-fA-F0-9])([a-fA-F0-9]{128})(?:[^a-fA-F0-9]|$)',
      caseSensitive: false,
    );

    if (sha512Pattern.hasMatch(value)) {
      final match = sha512Pattern.firstMatch(value)!.group(1)!;
      final firstChar = match[0];
      if (!match.split('').every((c) => c == firstChar)) {
        return true;
      }
    }

    return false;
  }

  /// Detects if a string contains RSA key patterns.
  /// This includes SSH RSA keys, JWK RSA keys, and other common formats.
  static bool containsRSAKey(String value) {
    // SSH RSA public key format
    if (value.contains('ssh-rsa ')) {
      return true;
    }

    // JWK RSA key indicators
    if (value.contains('"kty":"RSA"') || value.contains('"kty": "RSA"')) {
      return true;
    }

    // Common RSA key property names in JSON
    final rsaJsonPattern = RegExp(
      r'"(?:modulus|publicExponent|privateExponent|prime1|prime2|exponent1|exponent2|coefficient)"\s*:',
    );
    if (rsaJsonPattern.hasMatch(value)) {
      return true;
    }

    // RSA key headers in various formats (some covered by containsBase64)
    final rsaHeaders = [
      'RSA PRIVATE KEY',
      'RSA PUBLIC KEY',
      'PUBLIC KEY',
      'PRIVATE KEY',
    ];

    for (final header in rsaHeaders) {
      if (value.contains(header)) {
        return true;
      }
    }

    // Look for very long hex sequences that might be RSA modulus (typically 2048+ bits = 512+ hex chars)
    final longHexPattern = RegExp(r'[a-fA-F0-9]{512,}');
    if (longHexPattern.hasMatch(value)) {
      return true;
    }

    return false;
  }

  /// Detects if a string contains MD5 hash (32 hex characters).
  static bool containsMD5Hash(String value) {
    // MD5 produces 128 bits = 16 bytes = 32 hex characters
    final md5Pattern = RegExp(
      r'(?:^|[^a-fA-F0-9])([a-fA-F0-9]{32})(?:[^a-fA-F0-9]|$)',
      caseSensitive: false,
    );

    if (md5Pattern.hasMatch(value)) {
      final match = md5Pattern.firstMatch(value)!.group(1)!;
      final firstChar = match[0];
      // Check it's not all the same character
      if (!match.split('').every((c) => c == firstChar)) {
        // Additional check: ensure it's not part of a longer hex string
        // (to avoid matching parts of SHA256/SHA512)
        final fullPattern = RegExp(
          r'(?:^|[^a-fA-F0-9])' + match + r'(?:[^a-fA-F0-9]|$)',
          caseSensitive: false,
        );
        return fullPattern.hasMatch(value);
      }
    }

    return false;
  }

  /// Detects if a string contains a JWT (JSON Web Token).
  /// JWTs have three base64url parts separated by dots: header.payload.signature
  static bool containsJWT(String value) {
    // JWT pattern: three base64url segments separated by dots
    // Base64url uses A-Z, a-z, 0-9, -, _ (no padding)
    final jwtPattern = RegExp(
      r'(?:^|[^A-Za-z0-9_-])([A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+)(?:[^A-Za-z0-9_-]|$)',
    );

    if (jwtPattern.hasMatch(value)) {
      final match = jwtPattern.firstMatch(value)!.group(1)!;
      final parts = match.split('.');

      // Basic validation: each part should have reasonable length
      // Header and payload are usually at least 20 chars, signature varies
      if (parts[0].length >= 20 &&
          parts[1].length >= 20 &&
          parts[2].length >= 20) {
        // Additional check: try to detect if it looks like base64url
        // (has good mix of characters, not all uppercase/lowercase)
        for (final part in parts) {
          final hasUpper = RegExp(r'[A-Z]').hasMatch(part);
          final hasLower = RegExp(r'[a-z]').hasMatch(part);
          final hasDigit = RegExp(r'[0-9]').hasMatch(part);

          // Real JWTs typically have mix of character types
          if (hasUpper && hasLower && hasDigit) {
            return true;
          }
        }
      }
    }

    return false;
  }

  /// Detects if a string contains a UUID/GUID.
  /// Standard format: 8-4-4-4-12 hex characters (e.g., 550e8400-e29b-41d4-a716-446655440000)
  static bool containsUUID(String value) {
    // UUID v1-5 pattern: 8-4-4-4-12 format
    final uuidPattern = RegExp(
      r'(?:^|[^a-fA-F0-9-])([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12})(?:[^a-fA-F0-9-]|$)',
      caseSensitive: false,
    );

    if (uuidPattern.hasMatch(value)) {
      return true;
    }

    // Also check for UUID without dashes (some systems store them this way)
    final uuidNoDashPattern = RegExp(
      r'(?:^|[^a-fA-F0-9])([a-fA-F0-9]{32})(?:[^a-fA-F0-9]|$)',
      caseSensitive: false,
    );

    if (uuidNoDashPattern.hasMatch(value)) {
      final match = uuidNoDashPattern.firstMatch(value)!.group(1)!;
      // Additional heuristic: UUIDs often appear in specific contexts
      // Check for uuid/guid/id context to distinguish from MD5
      final contextPattern = RegExp(
        r'''(?:uuid|guid|id)[\s:="']?\s*["']?''' + match,
        caseSensitive: false,
      );
      if (contextPattern.hasMatch(value)) {
        return true;
      }
    }

    return false;
  }

  /// Detects if a string is suspect to not be user-facing based on arbitrary rules.
  /// Rule: For every 50 characters, there should be at least 1 space.
  /// This helps identify human-friendly strings vs keys/tokens/identifiers.
  /// Example: A 250-character string should have at least 5 spaces.
  static bool isSuspectToNotBeUserFacingString(String value) {
    if (value.isEmpty) return false;

    // Calculate required spaces based on string length
    final requiredSpaces = value.length ~/ 50;

    // If string is less than 50 chars, no spaces required
    if (requiredSpaces == 0) return false;

    // Count actual spaces in the string
    final actualSpaces = value.split(' ').length - 1;

    // If actual spaces are less than required, it's suspect
    return actualSpaces < requiredSpaces;
  }

  /// Detects if a string is a file reference (but not a valid path).
  /// This handles cases like:
  /// - Simple file names: session_provider.dart
  /// - Generated files: note_provider.g.dart, note_provider.freezed.dart
  /// - Variable interpolations: $prefix$key${user.id}
  /// - Relative paths with ../
  /// - Paths with $ variables
  static bool isFileReference(String value) {
    if (value.isEmpty) return false;

    // Check if it's already a valid path case (without special characters)
    if (isPathCase(value)) return false;

    // Check for relative paths starting with ../
    if (value.startsWith('../')) return true;

    // Check for paths containing $ variables
    if (RegExp(r'[\/\\]').hasMatch(value) && RegExp(r'\$').hasMatch(value)) {
      return true;
    }

    // Check for file extensions
    if (containsFileReference(value)) return true;

    // Check for variable interpolations (e.g., $prefix$key${user.id})
    if (RegExp(r'\$').hasMatch(value)) return true;

    return false;
  }

  /// Detects if a string contains programming-related file references.
  /// This includes:
  /// - Dart file names (*.dart)
  /// - Generated file patterns (*.g.dart, *.freezed.dart, *.pb.dart)
  /// - Package imports with file extensions (package:...*.dart)
  /// - Common programming file extensions
  static bool containsFileReference(String value) {
    // Check for Dart-specific file patterns
    if (value.endsWith('.dart')) {
      return true;
    }

    // Check for common generated file patterns
    final generatedPatterns = [
      RegExp(r'\.g\.\w+$'), // .g.dart, .g.json, etc.
      RegExp(r'\.freezed\.\w+$'), // .freezed.dart
      RegExp(r'\.pb\.\w+$'), // .pb.dart (protobuf)
      RegExp(r'\.pbenum\.\w+$'), // .pbenum.dart
      RegExp(r'\.pbgrpc\.\w+$'), // .pbgrpc.dart
      RegExp(r'\.pbjson\.\w+$'), // .pbjson.dart
    ];

    for (final pattern in generatedPatterns) {
      if (pattern.hasMatch(value)) {
        return true;
      }
    }

    // Check for common programming file extensions
    final programmingExtensions = [
      '.js',
      '.ts',
      '.jsx',
      '.tsx',
      '.py',
      '.rb',
      '.go',
      '.rs',
      '.java',
      '.kt',
      '.swift',
      '.m',
      '.h',
      '.cpp',
      '.c',
      '.cs',
      '.php',
      '.lua',
      '.sh',
      '.bash',
      '.zsh',
      '.fish',
      '.ps1',
      '.bat',
      '.cmd',
      '.json',
      '.xml',
      '.yaml',
      '.yml',
      '.toml',
      '.ini',
      '.conf',
      '.md',
      '.rst',
      '.txt',
      '.log',
      '.sql',
      '.graphql',
      '.proto',
    ];

    for (final ext in programmingExtensions) {
      if (value.endsWith(ext)) {
        return true;
      }
    }

    return false;
  }

  /// Detects if a string looks like a Firebase App ID.
  /// Firebase App IDs follow the pattern: numeric:numeric:platform:alphanumeric
  /// Examples:
  /// - 1:515286619892:web:2630b144e9f5abe26630a1
  /// - 1:624574984834:web:33d55a9ff038e16d72ba9b
  /// - 1:515286619892:ios:7713b8c61ad139b56630a1
  /// - 1:515286619892:android:c9ebb42700dfc53f6630a1
  static bool isFirebaseAppIdLike(String value) {
    if (value.isEmpty) return false;

    final firebaseAppIdPattern = RegExp(r'^[a-zA-Z0-9:]+$');
    return firebaseAppIdPattern.hasMatch(value);
  }

  static bool isAnyCase(String value) {
    return containsBase64(value) ||
        isImportCase(value) ||
        isCamelCase(value) ||
        isConstantCase(value) ||
        isDotCase(value) ||
        isHeaderCase(value) ||
        isPascalCase(value) ||
        isPascalDotCase(value) ||
        isParamCase(value) ||
        isPathCase(value) ||
        isSnakeCase(value) ||
        isOnlyNumber(value) ||
        containsSha1Key(value) ||
        // This includes SHA224, SHA256, SHA384, SHA512
        containsSha2Key(value) ||
        containsRSAKey(value) ||
        containsMD5Hash(value) ||
        containsJWT(value) ||
        containsUUID(value) ||
        isSuspectToNotBeUserFacingString(value) ||
        containsFileReference(value) ||
        isFileReference(value) ||
        isFirebaseAppIdLike(value);
  }
}
