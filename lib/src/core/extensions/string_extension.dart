import 'package:gobabel_core/gobabel_core.dart';

extension StringExtension on String {
  /// Transforms the string to camelCase.
  ///
  /// - Trims leading/trailing whitespace.
  /// - Splits by spaces, hyphens, or underscores.
  /// - The first word is converted to lowercase.
  /// - Subsequent words have their first letter capitalized and the rest lowercased.
  ///
  /// If the original string (after trimming) or the resulting camelCase string
  /// is empty, it returns "emptyVariable".
  String get toCamelCaseOrEmpty {
    if (CaseIdentifyRegex.isCamelCase(trim())) {
      final trimmed = trim();
      // Verify it only contains letters and numbers and doesn't start with number
      if (RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$').hasMatch(trimmed)) {
        return trimmed;
      }
    }
    // 1. Check if the original string is "empty" (after trimming)
    final trimmedOriginal = trim();
    if (trimmedOriginal.isEmpty) {
      return "emptyVariable";
    }

    // 2. Split into words using any non-alphanumeric characters as delimiters
    //    This will split on spaces, special characters, etc.
    List<String> words =
        trimmedOriginal
            .split(RegExp(r'[^a-zA-Z0-9]+'))
            .where((part) => part.isNotEmpty)
            .toList();

    // 3. If no valid words are found after splitting
    if (words.isEmpty) {
      return "emptyVariable";
    }

    // 4. Clean each word to only contain alphanumeric characters
    //    (this is redundant given our split regex, but kept for safety)
    List<String> cleanedWords =
        words
            .map((word) => word.replaceAll(RegExp(r'[^a-zA-Z0-9]'), ''))
            .where((word) => word.isNotEmpty)
            .toList();

    if (cleanedWords.isEmpty) {
      return "emptyVariable";
    }

    // 5. Construct the camelCase string
    String camelCaseResult = cleanedWords.first.toLowerCase();

    for (int i = 1; i < cleanedWords.length; i++) {
      String word = cleanedWords[i];
      if (word.isNotEmpty) {
        camelCaseResult +=
            word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
    }

    // 6. Check if result starts with a number
    if (camelCaseResult.isNotEmpty &&
        RegExp(r'^[0-9]').hasMatch(camelCaseResult)) {
      // Prefix with 'var' if it starts with a number
      camelCaseResult =
          'var${camelCaseResult[0].toUpperCase()}${camelCaseResult.substring(1)}';
    }

    // 7. Final validation - ensure only letters and numbers
    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$').hasMatch(camelCaseResult)) {
      return "emptyVariable";
    }

    if (camelCaseResult.isEmpty) {
      return "emptyVariable";
    }

    return camelCaseResult;
  }

  String get formatToComment {
    return '  /// ${replaceAll(RegExp('\n'), '<p>\n/// ')}';
  }

  /*
  HardcodedString.value can be, for example:
  "Hello, $userName!"
  'Hello, $userName!'
  '''Hello, $userName!'''
  """Hello, $userName!"""

  Should return only raw Hello, $userName!
  */
  String get trimHardcodedString {
    if (length >= 6 && startsWith("'''") && endsWith("'''")) {
      return trim().substring(3, length - 3);
    }
    if (length >= 6 && startsWith('"""') && endsWith('"""')) {
      return trim().substring(3, length - 3);
    }

    if (length >= 4 && startsWith("''") && endsWith("''")) {
      return trim().substring(2, length - 2);
    }
    if (length >= 4 && startsWith('""') && endsWith('""')) {
      return trim().substring(2, length - 2);
    }

    if (length >= 2 && startsWith("\"") && endsWith("\"")) {
      return trim().substring(1, length - 1);
    }
    if (length >= 2 && startsWith('\'') && endsWith('\'')) {
      return trim().substring(1, length - 1);
    }

    if (length >= 2 && startsWith('"') && endsWith('"')) {
      return trim().substring(1, length - 1);
    }

    if (length >= 2 && startsWith("'") && endsWith("'")) {
      return trim().substring(1, length - 1);
    }

    return trim();
  }
}
