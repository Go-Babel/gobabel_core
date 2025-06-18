import 'package:gobabel_core/gobabel_core.dart';

typedef NewL10nKey = L10nKey;

class GaranteeUniquenessOfArbKeysUsecase {
  const GaranteeUniquenessOfArbKeysUsecase();
  static final Map<TranslationKey, int> _alreadyCreatedUniqueKeys = {};
  static void clear() {
    _alreadyCreatedUniqueKeys.clear();
  }

  static void addUniqueKeys(TranslationKey newKey) {
    if (_alreadyCreatedUniqueKeys.containsKey(newKey)) {
      _alreadyCreatedUniqueKeys[newKey] =
          _alreadyCreatedUniqueKeys[newKey]! + 1;
    } else {
      _alreadyCreatedUniqueKeys[newKey] = 1;
    }
  }

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
    final currentCount = _alreadyCreatedUniqueKeys[baseKey] ?? 0;

    String finalKey = key;

    if (currentCount != 0) {
      final newCount = currentCount + 1;
      if (key.endsWith('_')) {
        finalKey = '$key$newCount';
      } else {
        finalKey = '${key}_$newCount';
      }
    }

    addUniqueKeys(finalKey);

    return finalKey;
  }
}
