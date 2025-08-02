import 'package:gobabel_core/gobabel_core.dart';
import 'package:test/test.dart';

void main() {
  group('shouldAutomaticallyBeConsideredAValidString', () {
    test('returns true for single capitalized word', () {
      expect(shouldAutomaticallyBeConsideredAValidString('Home'), isTrue);
      expect(shouldAutomaticallyBeConsideredAValidString('Dashboard'), isTrue);
      expect(shouldAutomaticallyBeConsideredAValidString('Settings'), isTrue);
    });

    test('returns false for lowercase or non-capitalized words', () {
      expect(shouldAutomaticallyBeConsideredAValidString('home'), isFalse);
      expect(shouldAutomaticallyBeConsideredAValidString('dashboard'), isFalse);
      expect(shouldAutomaticallyBeConsideredAValidString('settings'), isFalse);
    });

    test('returns false for multiple words', () {
      expect(shouldAutomaticallyBeConsideredAValidString('Home Page'), isFalse);
      expect(
        shouldAutomaticallyBeConsideredAValidString('Main Dashboard'),
        isFalse,
      );
    });

    test('returns false for words with numbers or symbols', () {
      expect(shouldAutomaticallyBeConsideredAValidString('Home1'), isFalse);
      expect(
        shouldAutomaticallyBeConsideredAValidString('Dashboard!'),
        isFalse,
      );
    });
  });
}
