import 'package:gobabel_core/gobabel_core.dart';

typedef NewL10nKey = L10nKey;

class GaranteeUniquenessOfArbKeysUsecase {
  const GaranteeUniquenessOfArbKeysUsecase();
  static Set<String> alreadyCreatedUniqueKeys = {};

  NewL10nKey call(L10nKey key) {
    // Thease parts will throw the error "expected_identifier_but_got_keyword" if used as a function name
    // so if funcName is exactly one of these parts, we will append "Func" to it.
    final List<String> invalidFuncNames = [
      'assert',
      'break',
      'case',
      'catch',
      'class',
      'const',
      'continue',
      'default',
      'do',
      'else',
      'enum',
      'extends',
      'false',
      'final',
      'finally',
      'for',
      'if',
      'in',
      'is',
      'new',
      'null',
      'rethrow',
      'return',
      'super',
      'switch',
      'this',
      'throw',
      'true',
      'try',
      'var',
      'void',
      'while',
      'with',
    ];

    if (invalidFuncNames.contains(key)) {
      key += '_';
    }

    if (!alreadyCreatedUniqueKeys.contains(key)) {
      alreadyCreatedUniqueKeys.add(key);
      return key;
    }

    final regex = RegExp(r'_(\d+)$');
    final match = regex.firstMatch(key);

    if (match == null) {
      final newKey = '${key}_2';
      alreadyCreatedUniqueKeys.add(newKey);
      return newKey;
    }

    final currentNumber = int.parse(match.group(1)!);
    final newNumber = currentNumber + 1;
    final newKey = key.replaceFirst(regex, '_$newNumber');
    alreadyCreatedUniqueKeys.add(newKey);
    return newKey;
  }
}
