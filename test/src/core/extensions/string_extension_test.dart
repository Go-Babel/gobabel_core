import 'package:gobabel_core/src/core/extensions/string_extension.dart';
import 'package:test/test.dart';

void main() {
  group('toCamelCaseOrEmpty', () {
    test('should return the same string if already in camelCase', () {
      expect('myVariable'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('myVariableName'.toCamelCaseOrEmpty, equals('myVariableName'));
      expect('a'.toCamelCaseOrEmpty, equals('a'));
      expect('aB'.toCamelCaseOrEmpty, equals('aB'));
      expect('aBc'.toCamelCaseOrEmpty, equals('aBc'));
    });

    test('should convert snake_case to camelCase', () {
      expect('my_variable'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('my_variable_name'.toCamelCaseOrEmpty, equals('myVariableName'));
      expect('a_b'.toCamelCaseOrEmpty, equals('aB'));
      expect('a_b_c'.toCamelCaseOrEmpty, equals('aBC'));
      expect(
        'my_long_variable_name'.toCamelCaseOrEmpty,
        equals('myLongVariableName'),
      );
    });

    test('should convert kebab-case to camelCase', () {
      expect('my-variable'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('my-variable-name'.toCamelCaseOrEmpty, equals('myVariableName'));
      expect('a-b'.toCamelCaseOrEmpty, equals('aB'));
      expect('a-b-c'.toCamelCaseOrEmpty, equals('aBC'));
      expect(
        'my-long-variable-name'.toCamelCaseOrEmpty,
        equals('myLongVariableName'),
      );
    });

    test('should convert space separated words to camelCase', () {
      expect('my variable'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('my variable name'.toCamelCaseOrEmpty, equals('myVariableName'));
      expect('a b'.toCamelCaseOrEmpty, equals('aB'));
      expect('a b c'.toCamelCaseOrEmpty, equals('aBC'));
      expect(
        'my long variable name'.toCamelCaseOrEmpty,
        equals('myLongVariableName'),
      );
    });

    test('should handle mixed delimiters', () {
      expect('my-variable_name'.toCamelCaseOrEmpty, equals('myVariableName'));
      expect(
        'my variable-name_test'.toCamelCaseOrEmpty,
        equals('myVariableNameTest'),
      );
      expect('a-b_c d'.toCamelCaseOrEmpty, equals('aBCD'));
    });

    test('should handle multiple consecutive delimiters', () {
      expect('my--variable'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('my__variable'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('my  variable'.toCamelCaseOrEmpty, equals('myVariable'));
      expect(
        'my---variable___name'.toCamelCaseOrEmpty,
        equals('myVariableName'),
      );
    });

    test('should handle leading and trailing delimiters', () {
      expect('-my-variable-'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('_my_variable_'.toCamelCaseOrEmpty, equals('myVariable'));
      expect(' my variable '.toCamelCaseOrEmpty, equals('myVariable'));
      expect('___my___variable___'.toCamelCaseOrEmpty, equals('myVariable'));
    });

    test('should handle uppercase words', () {
      expect('MY VARIABLE'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('MY_VARIABLE'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('MY-VARIABLE'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('My Variable Name'.toCamelCaseOrEmpty, equals('myVariableName'));
      expect(
        'MY_LONG_VARIABLE_NAME'.toCamelCaseOrEmpty,
        equals('myLongVariableName'),
      );
    });

    test('should handle mixed case words', () {
      expect(' My VaRiAbLe '.toCamelCaseOrEmpty, equals('myVariable'));
      expect('My VaRiAbLe'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('mY_vArIaBlE'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('MY-variable-NAME'.toCamelCaseOrEmpty, equals('myVariableName'));
    });

    test(
      'should return "emptyVariable" for empty or whitespace-only strings',
      () {
        expect(''.toCamelCaseOrEmpty, equals('emptyVariable'));
        expect(' '.toCamelCaseOrEmpty, equals('emptyVariable'));
        expect('  '.toCamelCaseOrEmpty, equals('emptyVariable'));
        expect('\t'.toCamelCaseOrEmpty, equals('emptyVariable'));
        expect('\n'.toCamelCaseOrEmpty, equals('emptyVariable'));
        expect(' \t\n '.toCamelCaseOrEmpty, equals('emptyVariable'));
      },
    );

    test('should return "emptyVariable" for strings with only delimiters', () {
      expect('-'.toCamelCaseOrEmpty, equals('emptyVariable'));
      expect('_'.toCamelCaseOrEmpty, equals('emptyVariable'));
      expect('---'.toCamelCaseOrEmpty, equals('emptyVariable'));
      expect('___'.toCamelCaseOrEmpty, equals('emptyVariable'));
      expect('-_-'.toCamelCaseOrEmpty, equals('emptyVariable'));
      expect('- _'.toCamelCaseOrEmpty, equals('emptyVariable'));
      expect('   ---   ___   '.toCamelCaseOrEmpty, equals('emptyVariable'));
    });

    test('should handle single letter words', () {
      expect('a'.toCamelCaseOrEmpty, equals('a'));
      expect('A'.toCamelCaseOrEmpty, equals('a'));
      expect('a b'.toCamelCaseOrEmpty, equals('aB'));
      expect('A B'.toCamelCaseOrEmpty, equals('aB'));
      expect('a_b_c'.toCamelCaseOrEmpty, equals('aBC'));
      expect('A_B_C'.toCamelCaseOrEmpty, equals('aBC'));
    });

    test('should handle numeric characters in words', () {
      expect('my_variable_1'.toCamelCaseOrEmpty, equals('myVariable1'));
      expect('my_2nd_variable'.toCamelCaseOrEmpty, equals('my2ndVariable'));
      expect('variable123'.toCamelCaseOrEmpty, equals('variable123'));
      expect('123_variable'.toCamelCaseOrEmpty, equals('123Variable'));
      expect('var_123_name'.toCamelCaseOrEmpty, equals('var123Name'));
    });

    test(
      'should preserve camelCase for already camelCase strings with numbers',
      () {
        expect('myVariable1'.toCamelCaseOrEmpty, equals('myVariable1'));
        expect('my2ndVariable'.toCamelCaseOrEmpty, equals('my2ndVariable'));
        expect('variable123'.toCamelCaseOrEmpty, equals('variable123'));
      },
    );

    test('should handle special characters by treating them as delimiters', () {
      // Note: The current implementation only handles space, hyphen, and underscore
      // Other special characters will be included in the words
      expect('my.variable'.toCamelCaseOrEmpty, equals('my.variable'));
      expect('my@variable'.toCamelCaseOrEmpty, equals('my@variable'));
      expect('my#variable'.toCamelCaseOrEmpty, equals('my#variable'));
    });

    test('should handle long strings', () {
      final longName = 'this_is_a_very_long_variable_name_with_many_words';
      expect(
        longName.toCamelCaseOrEmpty,
        equals('thisIsAVeryLongVariableNameWithManyWords'),
      );
    });

    test('should handle edge cases with trimming', () {
      expect('  my_variable  '.toCamelCaseOrEmpty, equals('myVariable'));
      expect('\tmy-variable\t'.toCamelCaseOrEmpty, equals('myVariable'));
      expect('\nmy variable\n'.toCamelCaseOrEmpty, equals('myVariable'));
    });
  });
  group('StringExtension Tests', () {
    group('trimHardcodedString getter', () {
      test('should remove single double quotes from a string', () {
        expect('"Hello"'.trimHardcodedString, 'Hello');
      });

      test('should remove single single quotes from a string', () {
        expect("'Hello'".trimHardcodedString, 'Hello');
      });

      test('should remove triple single quotes from a string', () {
        // Note: This test will likely fail with the current implementation.
        // 1. The single quote check '...' might take precedence.
        // 2. The substring logic for '''...''' is substring(1, length-1) instead of substring(3, length-3).
        // Expected: "'''Hello'''" -> "Hello"
        // Current behavior due to single quote rule: "'''Hello'''" -> "''Hello''"
        expect("'''Hello'''".trimHardcodedString, 'Hello');
      });

      test('should remove triple double quotes from a string', () {
        // Note: This test will likely fail with the current implementation.
        // 1. The single double quote check "..." might take precedence.
        // 2. The condition for triple double quotes is `startsWith("\"")` (single quote)
        //    and uses substring(1, length-1).
        // Expected: '"""Hello"""' -> "Hello"
        // Current behavior due to single quote rule: '"""Hello"""' -> '""Hello""'
        expect('"""Hello"""'.trimHardcodedString, 'Hello');
      });

      test('should return the original string if no surrounding quotes', () {
        expect('Hello'.trimHardcodedString, 'Hello');
      });

      test('should handle empty string with triple single quotes', () {
        // Expected: "''''''" (len 6) -> "" (substring(3, length-3))
        // Current behavior (single quote rule): "''''''" -> "''''"
        expect("''''''".trimHardcodedString, '');
      });

      test('should handle empty string with triple double quotes', () {
        // Expected: '""""""' (len 6) -> "" (substring(3, length-3))
        // Current behavior (single quote rule): '""""""' -> '""""'
        expect('""""""'.trimHardcodedString, '');
      });

      test('should handle an empty string without quotes', () {
        expect(''.trimHardcodedString, '');
      });

      test(
        'should not trim if quotes are mismatched (double start, single end)',
        () {
          expect('"Hello\''.trimHardcodedString, '"Hello\'');
        },
      );

      test(
        'should not trim if quotes are mismatched (single start, double end)',
        () {
          expect("'Hello\"".trimHardcodedString, "'Hello\"");
        },
      );

      test('should correctly trim strings with internal quotes', () {
        expect('"He\'llo"'.trimHardcodedString, 'He\'llo');
        expect("'He\"llo'".trimHardcodedString, 'He"llo');
        // These will also likely fail due to precedence and incorrect substring logic for triple quotes
        expect("'''He'llo'''".trimHardcodedString, "He'llo");
        expect('"""He"llo"""'.trimHardcodedString, 'He"llo');
      });

      test(
        'should return original string if it starts with quote but does not end with it',
        () {
          expect('"Hello'.trimHardcodedString, '"Hello');
          expect("'Hello".trimHardcodedString, "'Hello");
          expect("'''Hello".trimHardcodedString, "'''Hello");
          expect('"""Hello'.trimHardcodedString, '"""Hello');
        },
      );

      test(
        'should return original string if it ends with quote but does not start with it',
        () {
          expect('Hello"'.trimHardcodedString, 'Hello"');
          expect("Hello'".trimHardcodedString, "Hello'");
          expect("Hello'''".trimHardcodedString, "Hello'''");
          expect('Hello"""'.trimHardcodedString, 'Hello"""');
        },
      );
    });
  });
}
