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

  static const String importCase =
      r'\w+:(?:(?:(?:\w|\.)+$)|'
      '(?:$pathCase))';
  // r'\w+:' + pathCase;
  static const String pathCase =
      '(?:$_pathCaseSlash)|(?:$_pathCaseFowardSlash)|(?:$_pathCaseRoute)';
  static const String _pathCaseRoute =
      r'([\/])(?:\w|-){1,}(?:\.\w+\1?)?'; // /splash, /splash.dart, /splash.dart/
  static const String _pathCaseSlash =
      r'(?<!\w)\/?\w{1,}(?:\/\w+){1,}\/?(?:.\w{1,}){0,}(?!\w)';
  static const String _pathCaseFowardSlash =
      r'(?<!\w)\\?\w{1,}(?:\\\w+){1,}\\?(?:.\w{1,}){0,}(?!\w)';
  static const String camelCase =
      r'(?<!\w)\d?([a-z][a-z0-9]+)([A-Z][a-z0-9]+){1,}(?!\w)';
  static const String constantCase =
      r'(?<!\w)[A-Z0-9]{1,}(?:_[A-Z0-9]+){1,}(?!\w)';
  static const String dotCase = r'(?<!\w)[a-z0-9]{1,}(?:\.[a-z0-9]+){1,}(?!\w)';
  static const String headerCase =
      r'(?<!\w)[A-Z][a-z0-9]{1,}(?:-[A-Z][a-z0-9]+){1,}(?!\w)';
  static const String pascalDotCase =
      r'(?<!\w)[A-Z][a-z0-9]{1,}(?:\.[A-Z][a-z0-9]+){1,}(?!\w)';
  static const String pascalCase = r'(?<!\w)\d?([A-Z][a-z0-9]+){2,}(?!\w)';
  static const String paramCase =
      r'(?<!\w)[a-z0-9]{1,}(?:-[a-z0-9]+){1,}(?!\w)';
  static const String snakeCase =
      r'(?<!\w)[a-z0-9]{1,}(?:_[a-z0-9]+){1,}(?!\w)';

  /// The FULL TEXT should be in the case you want to identify.
  static bool isCase(String value, String regex) {
    if (value.isEmpty) return false;

    final regExp = RegExp(regex, multiLine: true);
    final matches = regExp.allMatches(value);
    if (matches.isEmpty) return false;
    if (matches.length > 1) return false;
    return matches.first.start == 0 && matches.first.end == value.length;
  }

  static bool isImportCase(String value) => isCase(value, importCase);
  static bool isPathCase(String value) => isCase(value, '^(?:$pathCase)\$');
  static bool isCamelCase(String value) => isCase(value, camelCase);
  static bool isConstantCase(String value) => isCase(value, constantCase);
  static bool isDotCase(String value) => isCase(value, dotCase);
  static bool isHeaderCase(String value) => isCase(value, headerCase);
  static bool isPascalDotCase(String value) => isCase(value, pascalDotCase);
  static bool isPascalCase(String value) => isCase(value, pascalCase);
  static bool isParamCase(String value) => isCase(value, paramCase);
  static bool isSnakeCase(String value) => isCase(value, snakeCase);

  static bool isAnyCase(String value) {
    return isImportCase(value) ||
        isCamelCase(value) ||
        isConstantCase(value) ||
        isDotCase(value) ||
        isHeaderCase(value) ||
        isPascalCase(value) ||
        isPascalDotCase(value) ||
        isParamCase(value) ||
        isPathCase(value) ||
        isSnakeCase(value);
  }
}
