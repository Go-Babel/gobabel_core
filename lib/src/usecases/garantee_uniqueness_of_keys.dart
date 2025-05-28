import 'package:gobabel_core/gobabel_core.dart';

typedef NewL10nKey = L10nKey;

class GaranteeUniquenessOfArbKeysUsecase {
  const GaranteeUniquenessOfArbKeysUsecase();
  static Set<String> alreadyCreatedUniqueKeys = {};
  NewL10nKey call(L10nKey key) {
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
