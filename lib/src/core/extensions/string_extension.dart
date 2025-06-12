extension StringExtension on String {
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
      return substring(3, length - 3);
    }
    if (length >= 6 && startsWith('"""') && endsWith('"""')) {
      return substring(3, length - 3);
    }

    if (length >= 4 && startsWith("''") && endsWith("''")) {
      return substring(2, length - 2);
    }
    if (length >= 4 && startsWith('""') && endsWith('""')) {
      return substring(2, length - 2);
    }

    if (length >= 2 && startsWith("\"") && endsWith("\"")) {
      return substring(1, length - 1);
    }
    if (length >= 2 && startsWith('\'') && endsWith('\'')) {
      return substring(1, length - 1);
    }

    if (length >= 2 && startsWith('"') && endsWith('"')) {
      return substring(1, length - 1);
    }

    if (length >= 2 && startsWith("'") && endsWith("'")) {
      return substring(1, length - 1);
    }

    return this;
  }
}
