import 'package:gobabel_core/src/core/extensions/string_extension.dart';
import 'package:test/test.dart';

void main() {
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
