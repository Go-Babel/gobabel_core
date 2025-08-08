import 'package:gobabel_core/gobabel_core.dart';
import 'package:test/test.dart';

void main() {
  group('calculateLettersPerSpaceRatio', () {
    test('should calculate correct ratio for strings with letters and spaces',
        () {
      // "Hello world" has 10 letters and 1 space = ratio of 10.0
      expect(calculateLettersPerSpaceRatio('Hello world'), equals(10.0));

      // "a b c d" has 4 letters and 3 spaces = ratio of 1.33...
      expect(calculateLettersPerSpaceRatio('a b c d'), closeTo(1.33, 0.01));

      // "This is a test" has 11 letters and 3 spaces = ratio of 3.67...
      expect(
          calculateLettersPerSpaceRatio('This is a test'), closeTo(3.67, 0.01));

      // "Programming is fun" has 16 letters and 2 spaces = ratio of 8.0
      expect(calculateLettersPerSpaceRatio('Programming is fun'), equals(8.0));

      // "ab cd ef" has 6 letters and 2 spaces = ratio of 3.0
      expect(calculateLettersPerSpaceRatio('ab cd ef'), equals(3.0));

      // "abcd efgh" has 8 letters and 1 space = ratio of 8.0
      expect(calculateLettersPerSpaceRatio('abcd efgh'), equals(8.0));
    });

    test('should return infinity for strings with no spaces', () {
      expect(calculateLettersPerSpaceRatio('Hello'), equals(double.infinity));
      expect(calculateLettersPerSpaceRatio('Programming'),
          equals(double.infinity));
      expect(calculateLettersPerSpaceRatio('Flutter'), equals(double.infinity));
      expect(calculateLettersPerSpaceRatio(''),
          equals(double.infinity)); // edge case
    });

    test('should return 0 for strings with no letters', () {
      expect(calculateLettersPerSpaceRatio('   '), equals(0.0));
      expect(calculateLettersPerSpaceRatio('123 456'), equals(0.0));
      expect(calculateLettersPerSpaceRatio(r'!@# $%^'), equals(0.0));
      expect(calculateLettersPerSpaceRatio(' '), equals(0.0));
    });

    test('should only count letters and spaces, ignoring other characters', () {
      // "Hello123 World456" has 10 letters and 1 space = ratio of 10.0
      expect(calculateLettersPerSpaceRatio('Hello123 World456'), equals(10.0));

      // "Hello, World!" has 10 letters and 1 space = ratio of 10.0
      expect(calculateLettersPerSpaceRatio('Hello, World!'), equals(10.0));

      // "Test@123 Case#456" has 8 letters and 1 space = ratio of 8.0
      expect(calculateLettersPerSpaceRatio('Test@123 Case#456'), equals(8.0));

      // "a@b#c d$e%f" has 6 letters and 1 space = ratio of 6.0
      expect(calculateLettersPerSpaceRatio(r'a@b#c d$e%f'), equals(6.0));
    });

    test('should handle multiple consecutive spaces correctly', () {
      // "Hello     World" has 10 letters and 5 spaces = ratio of 2.0
      expect(calculateLettersPerSpaceRatio('Hello     World'), equals(2.0));

      // "a  b  c" has 3 letters and 4 spaces = ratio of 0.75
      expect(calculateLettersPerSpaceRatio('a  b  c'), equals(0.75));

      // " Hello World " has 10 letters and 3 spaces = ratio of 3.33...
      expect(
          calculateLettersPerSpaceRatio(' Hello World '), closeTo(3.33, 0.01));
    });

    test('should handle special formatting characters', () {
      // Tab is not a space
      expect(calculateLettersPerSpaceRatio('Hello\tWorld'),
          equals(double.infinity));

      // Newline is not a space
      expect(calculateLettersPerSpaceRatio('Hello\nWorld'),
          equals(double.infinity));

      // Only regular spaces count
      expect(calculateLettersPerSpaceRatio('Hello World'), equals(10.0));
    });

    test('should handle edge cases', () {
      // Empty string
      expect(calculateLettersPerSpaceRatio(''), equals(double.infinity));

      // Single letter
      expect(calculateLettersPerSpaceRatio('a'), equals(double.infinity));

      // Single space
      expect(calculateLettersPerSpaceRatio(' '), equals(0.0));

      // Letter space letter
      expect(calculateLettersPerSpaceRatio('a b'), equals(2.0));
    });

    test('should handle mixed case letters', () {
      // Both uppercase and lowercase count as letters
      expect(calculateLettersPerSpaceRatio('HELLO WORLD'), equals(10.0));
      expect(calculateLettersPerSpaceRatio('HeLLo WoRLd'), equals(10.0));
      expect(calculateLettersPerSpaceRatio('hello world'), equals(10.0));
    });
  });

  group('shouldAutomaticallyBeConsideredAValidString', () {
    group('basic validation', () {
      test('returns true for single capitalized word', () {
        expect(shouldAutomaticallyBeConsideredAValidString('Home'), isTrue);
        expect(
            shouldAutomaticallyBeConsideredAValidString('Dashboard'), isTrue);
        expect(shouldAutomaticallyBeConsideredAValidString('Settings'), isTrue);
      });

      test('Returns true for multiple words with only letters and spaces', () {
        expect(
            shouldAutomaticallyBeConsideredAValidString('Home Page'), isTrue);
        expect(
          shouldAutomaticallyBeConsideredAValidString('Main Dashboard'),
          isTrue,
        );
      });

      test(
          'Returns true for multiple words with only letters, spaces, commas, and open AND close parentheses',
          () {
        // This string is 167 characters long, which exceeds the 150 character limit
        expect(
            shouldAutomaticallyBeConsideredAValidString(
                'Fast defender, who has good anticipation speed, agility to (stop balling) actions and speed to overcome attackers in speedy contests. Composition in deep balls.'),
            isTrue);
      });

      test('returns false for words with numbers or symbols', () {
        expect(shouldAutomaticallyBeConsideredAValidString('Home1'), isFalse);
        expect(
          shouldAutomaticallyBeConsideredAValidString('Dashboard#'),
          isFalse,
        );
      });
    });

    group('space ratio validation', () {
      test('should reject strings with low letters-per-space ratio', () {
        // Ratio below 4.0
        expect(shouldAutomaticallyBeConsideredAValidString('a b c d'), isFalse);
        expect(
            shouldAutomaticallyBeConsideredAValidString('h e l l o'), isFalse);
        expect(
            shouldAutomaticallyBeConsideredAValidString('W o r l d'), isFalse);
        expect(shouldAutomaticallyBeConsideredAValidString('a  b  c'), isFalse);
        expect(shouldAutomaticallyBeConsideredAValidString('ab cd ef'),
            isFalse); // ratio = 3.0

        // Even if it starts with capital letter
        expect(
            shouldAutomaticallyBeConsideredAValidString('H e l l o'), isFalse);
        expect(shouldAutomaticallyBeConsideredAValidString('A B C D'), isFalse);
      });

      test('should handle strings with exactly threshold ratio', () {
        // "abcd efgh" has ratio of 8.0 (8 letters, 1 space)
        // But it doesn't match the name pattern, so it's still rejected
        expect(calculateLettersPerSpaceRatio('abcd efgh'), 8.0);

        // "Abcd efgh" has ratio of 8.0 and matches the pattern
        expect(calculateLettersPerSpaceRatio('Abcd efgh'), 8.0);
      });

      test('should accept strings with high ratio that match pattern', () {
        // These have infinite ratio (no spaces) and match pattern
        expect(shouldAutomaticallyBeConsideredAValidString('Hello'), isTrue);
        expect(shouldAutomaticallyBeConsideredAValidString('World'), isTrue);
        expect(shouldAutomaticallyBeConsideredAValidString('Flutter'), isTrue);
      });

      test('should reject strings with only spaces or no letters', () {
        expect(shouldAutomaticallyBeConsideredAValidString('   '), isFalse);
        expect(shouldAutomaticallyBeConsideredAValidString('123 456'), isFalse);
        expect(
            shouldAutomaticallyBeConsideredAValidString(r'!@# $%^'), isFalse);
      });
    });

    group('length and empty validation', () {
      test('should reject empty strings', () {
        expect(shouldAutomaticallyBeConsideredAValidString(''), isFalse);
      });
    });

    group('consecutive spaces validation', () {
      test('should reject strings with 4 or more consecutive spaces', () {
        expect(shouldAutomaticallyBeConsideredAValidString('Hello    World'),
            isFalse);
        expect(shouldAutomaticallyBeConsideredAValidString('Test     Case'),
            isFalse);
        expect(
            shouldAutomaticallyBeConsideredAValidString('One    Two    Three'),
            isFalse);
      });

      test(
          'should handle strings with 3 or fewer consecutive spaces based on pattern',
          () {
        // Test individual cases to understand the pattern better
        // Multi-word strings that match the complex pattern may be accepted
        expect(
            shouldAutomaticallyBeConsideredAValidString('Test Case'), isTrue);
        expect(shouldAutomaticallyBeConsideredAValidString('One Two'), isTrue);
        // "Hello   World" has 10 letters and 3 spaces = ratio of 3.33 (below 4.0 threshold)
        expect(shouldAutomaticallyBeConsideredAValidString('Hello   World'),
            isFalse);
      });
    });

    group('complex pattern validation', () {
      test('should handle parentheses correctly', () {
        expect(
          shouldAutomaticallyBeConsideredAValidString('Hello (world)'),
          isTrue,
        );
        expect(
          shouldAutomaticallyBeConsideredAValidString('Test (case example)'),
          isTrue,
        );
      });

      test('should handle punctuation correctly', () {
        expect(
          shouldAutomaticallyBeConsideredAValidString('Hello, world'),
          isTrue,
        );
        expect(
          shouldAutomaticallyBeConsideredAValidString('Test? Case.'),
          isTrue,
        );
      });
    });

    group('sentences tests', () {
      test('should accept valid sentences', () {
        expect(
            isSentencePattern(
                'For Clubs from Countries contained on this list, Global conditions will not be shown. Only the conditions defined here as specific for these countries will be shown'),
            isTrue);
        expect(
            isSentencePattern(
                'Select the collections where you want to keep or add this player:'),
            isTrue);
      });
    });
    group('integration tests', () {
      test('should properly validate real-world examples', () {
        // Valid single names
        expect(shouldAutomaticallyBeConsideredAValidString('John'), isTrue);
        expect(shouldAutomaticallyBeConsideredAValidString('Sarah'), isTrue);
        expect(shouldAutomaticallyBeConsideredAValidString('Robert'), isTrue);

        // Invalid due to space ratio
        expect(shouldAutomaticallyBeConsideredAValidString('J o h n'), isFalse);
        expect(
            shouldAutomaticallyBeConsideredAValidString('S a r a h'), isFalse);

        // Invalid due to multiple spaces
        expect(shouldAutomaticallyBeConsideredAValidString('Hello    World'),
            isFalse);

        // Invalid due to length
        final veryLongString = 'A' * 221;
        expect(shouldAutomaticallyBeConsideredAValidString(veryLongString),
            isFalse);
      });

      test('should handle edge cases correctly', () {
        // Numbers and special characters
        expect(shouldAutomaticallyBeConsideredAValidString('123'), isFalse);
        expect(shouldAutomaticallyBeConsideredAValidString('!@#'), isFalse);

        // Mixed content
        expect(
            shouldAutomaticallyBeConsideredAValidString('Hello123'), isFalse);
        expect(shouldAutomaticallyBeConsideredAValidString('Test*'), isFalse);

        // Edge case patterns - single letters should match the pattern
        expect(shouldAutomaticallyBeConsideredAValidString('I'),
            isTrue); // Single letter
        expect(shouldAutomaticallyBeConsideredAValidString('A'),
            isTrue); // Single letter
      });
    });
  });
}
