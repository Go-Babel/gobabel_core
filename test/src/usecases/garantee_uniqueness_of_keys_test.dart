import 'package:gobabel_core/gobabel_core.dart';
import 'package:test/test.dart';

void main() {
  group('GaranteeUniquenessOfArbKeysUsecase', () {
    late GaranteeUniquenessOfArbKeysUsecase usecase;

    setUp(() {
      usecase = const GaranteeUniquenessOfArbKeysUsecase();
      // Reset the static map before each test
      GaranteeUniquenessOfArbKeysUsecase.clear();
    });

    group('Basic uniqueness', () {
      test('should return the same key if it is unique', () {
        final result = usecase('myKey');
        expect(result, equals('myKey'));
      });

      test('should add "_2" to duplicate keys', () {
        usecase('myKey'); // First call
        final result = usecase('myKey'); // Second call
        expect(result, equals('myKey_2'));
      });

      test('should increment numbers for multiple duplicates', () {
        usecase('myKey'); // First call -> myKey
        usecase('myKey'); // Second call -> myKey_2
        final result = usecase('myKey'); // Third call -> myKey_3
        expect(result, equals('myKey_3'));
      });
    });

    group('Dart keyword handling', () {
      test('should append underscore to "new" keyword', () {
        final result = usecase('new');
        expect(result, equals('new_'));
      });

      test('should append underscore to "class" keyword', () {
        final result = usecase('class');
        expect(result, equals('class_'));
      });

      test('should handle multiple calls with same keyword', () {
        usecase('if'); // First call -> if_
        final result = usecase('if'); // Second call -> if__2
        expect(result, equals('if__2'));
      });

      test('should handle all invalid function names', () {
        final invalidNames = [
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

        for (final name in invalidNames) {
          final result = usecase(name);
          expect(result, equals('${name}_'));
        }
      });
    });

    group('Numbering system', () {
      test('should handle keys with multiple underscores', () {
        usecase('my_complex_key'); // First call -> my_complex_key
        final result = usecase(
          'my_complex_key',
        ); // Second call -> my_complex_key_2
        expect(result, equals('my_complex_key_2'));
      });

      test('should increment from existing number correctly', () {
        usecase('test_10'); // First call -> test_10
        final result = usecase('test_10'); // Second call -> test_11
        expect(result, equals('test_10_2'));
      });
    });

    group('Edge cases', () {
      test('should handle empty string', () {
        final result = usecase('');
        expect(result, equals(''));
      });

      test('should handle keys with only underscores', () {
        usecase('_'); // First call -> _
        final result = usecase('_'); // Second call -> __2
        expect(result, equals('__2'));
      });

      test('should handle combination of keyword and numbering', () {
        usecase('new'); // First call -> new_
        final result = usecase('new'); // Second call -> new__2
        expect(result, equals('new__2'));
      });

      test('should maintain state across multiple different keys', () {
        final result1 = usecase('key1');
        final result2 = usecase('key2');
        final result3 = usecase('key1'); // Duplicate
        final result4 = usecase('key2'); // Duplicate

        expect(result1, equals('key1'));
        expect(result2, equals('key2'));
        expect(result3, equals('key1_2'));
        expect(result4, equals('key2_2'));
      });
    });

    group('Complex scenarios', () {
      test('should handle multiple increments correctly', () {
        usecase('test'); // test
        usecase('test'); // test_2
        usecase('test'); // test_3
        usecase('test'); // test_4
        final result = usecase('test'); // test_5
        expect(result, equals('test_5'));
      });

      test('should handle mixed keyword and regular keys', () {
        final result1 = usecase('regularKey');
        final result2 = usecase('for');
        final result3 = usecase('regularKey');
        final result4 = usecase('for');

        expect(result1, equals('regularKey'));
        expect(result2, equals('for_'));
        expect(result3, equals('regularKey_2'));
        expect(result4, equals('for__2'));
      });
    });
  });
}
