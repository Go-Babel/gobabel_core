import 'package:gobabel_core/gobabel_core.dart';

typedef NewL10nKey = L10nKey;

class GaranteeUniquenessOfArbKeysUsecase {
  const GaranteeUniquenessOfArbKeysUsecase();
  static Map<String, int> alreadyCreatedUniqueKeys = {};

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

    final baseKey = key;
    final currentCount = alreadyCreatedUniqueKeys[baseKey] ?? 0;

    if (currentCount == 0) {
      alreadyCreatedUniqueKeys[baseKey] = 1;
      return key;
    }

    final newCount = currentCount + 1;
    alreadyCreatedUniqueKeys[baseKey] = newCount;
    return '${key}_$newCount';
  }
}
