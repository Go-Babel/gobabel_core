import 'package:gobabel_core/src/case_identify.dart';
import 'package:test/test.dart';

void main() {
  group('CaseIdentifyRegex', () {
    group('isCamelCase', () {
      test('should identify valid camelCase', () {
        expect(CaseIdentifyRegex.isCamelCase('helloWorld'), isTrue);
        expect(CaseIdentifyRegex.isCamelCase('myVariableName'), isTrue);
        expect(CaseIdentifyRegex.isCamelCase('getUserById'), isTrue);
        expect(CaseIdentifyRegex.isCamelCase('isActive'), isTrue);
        expect(CaseIdentifyRegex.isCamelCase('hasValue'), isTrue);
        expect(CaseIdentifyRegex.isCamelCase('myVar123'), isTrue);
        expect(CaseIdentifyRegex.isCamelCase('parseJSON'), isTrue);
        expect(CaseIdentifyRegex.isCamelCase('toHTMLString'), isTrue);
      });

      test('should reject invalid camelCase', () {
        expect(CaseIdentifyRegex.isCamelCase('hello'), isFalse); // Single word
        expect(CaseIdentifyRegex.isCamelCase('HelloWorld'), isFalse); // PascalCase
        expect(CaseIdentifyRegex.isCamelCase('hello_world'), isFalse); // snake_case
        expect(CaseIdentifyRegex.isCamelCase('hello-world'), isFalse); // param-case
        expect(CaseIdentifyRegex.isCamelCase('HELLO_WORLD'), isFalse); // CONSTANT_CASE
        expect(CaseIdentifyRegex.isCamelCase('hello world'), isFalse); // Space
        expect(CaseIdentifyRegex.isCamelCase('123hello'), isFalse); // Starts with number
        expect(CaseIdentifyRegex.isCamelCase(''), isFalse); // Empty
      });
    });

    group('isPascalCase', () {
      test('should identify valid PascalCase', () {
        expect(CaseIdentifyRegex.isPascalCase('HelloWorld'), isTrue);
        expect(CaseIdentifyRegex.isPascalCase('MyClassName'), isTrue);
        expect(CaseIdentifyRegex.isPascalCase('UserAccount'), isTrue);
        expect(CaseIdentifyRegex.isPascalCase('HttpResponse'), isTrue);
        expect(CaseIdentifyRegex.isPascalCase('XMLParser'), isTrue);
        expect(CaseIdentifyRegex.isPascalCase('IOError'), isTrue);
      });

      test('should reject invalid PascalCase', () {
        expect(CaseIdentifyRegex.isPascalCase('Hello'), isFalse); // Single word
        expect(CaseIdentifyRegex.isPascalCase('helloWorld'), isFalse); // camelCase
        expect(CaseIdentifyRegex.isPascalCase('hello_world'), isFalse); // snake_case
        expect(CaseIdentifyRegex.isPascalCase('HELLO_WORLD'), isFalse); // CONSTANT_CASE
        expect(CaseIdentifyRegex.isPascalCase('Hello-World'), isFalse); // Header-Case
        expect(CaseIdentifyRegex.isPascalCase('123HelloWorld'), isFalse); // Starts with number
        expect(CaseIdentifyRegex.isPascalCase(''), isFalse); // Empty
      });
    });

    group('isSnakeCase', () {
      test('should identify valid snake_case', () {
        expect(CaseIdentifyRegex.isSnakeCase('hello_world'), isTrue);
        expect(CaseIdentifyRegex.isSnakeCase('my_variable_name'), isTrue);
        expect(CaseIdentifyRegex.isSnakeCase('get_user_by_id'), isTrue);
        expect(CaseIdentifyRegex.isSnakeCase('is_active'), isTrue);
        expect(CaseIdentifyRegex.isSnakeCase('max_value_123'), isTrue);
      });

      test('should reject invalid snake_case', () {
        expect(CaseIdentifyRegex.isSnakeCase('hello'), isFalse); // Single word
        expect(CaseIdentifyRegex.isSnakeCase('helloWorld'), isFalse); // camelCase
        expect(CaseIdentifyRegex.isSnakeCase('HelloWorld'), isFalse); // PascalCase
        expect(CaseIdentifyRegex.isSnakeCase('HELLO_WORLD'), isFalse); // CONSTANT_CASE
        expect(CaseIdentifyRegex.isSnakeCase('hello-world'), isFalse); // param-case
        expect(CaseIdentifyRegex.isSnakeCase('hello_World'), isFalse); // Mixed case
        expect(CaseIdentifyRegex.isSnakeCase('_hello_world'), isFalse); // Leading underscore
        expect(CaseIdentifyRegex.isSnakeCase('hello_world_'), isFalse); // Trailing underscore
        expect(CaseIdentifyRegex.isSnakeCase(''), isFalse); // Empty
      });
    });

    group('isConstantCase', () {
      test('should identify valid CONSTANT_CASE', () {
        expect(CaseIdentifyRegex.isConstantCase('HELLO_WORLD'), isTrue);
        expect(CaseIdentifyRegex.isConstantCase('MAX_VALUE'), isTrue);
        expect(CaseIdentifyRegex.isConstantCase('API_KEY'), isTrue);
        expect(CaseIdentifyRegex.isConstantCase('HTTP_STATUS_OK'), isTrue);
        expect(CaseIdentifyRegex.isConstantCase('VERSION_2_0'), isTrue);
        expect(CaseIdentifyRegex.isConstantCase('ERROR_404'), isTrue);
      });

      test('should reject invalid CONSTANT_CASE', () {
        expect(CaseIdentifyRegex.isConstantCase('HELLO'), isFalse); // Single word
        expect(CaseIdentifyRegex.isConstantCase('hello_world'), isFalse); // lowercase
        expect(CaseIdentifyRegex.isConstantCase('Hello_World'), isFalse); // Mixed case
        expect(CaseIdentifyRegex.isConstantCase('HELLO-WORLD'), isFalse); // Dash separator
        expect(CaseIdentifyRegex.isConstantCase('helloWorld'), isFalse); // camelCase
        expect(CaseIdentifyRegex.isConstantCase('_HELLO_WORLD'), isFalse); // Leading underscore
        expect(CaseIdentifyRegex.isConstantCase(''), isFalse); // Empty
      });
    });

    group('isParamCase', () {
      test('should identify valid param-case', () {
        expect(CaseIdentifyRegex.isParamCase('hello-world'), isTrue);
        expect(CaseIdentifyRegex.isParamCase('my-variable-name'), isTrue);
        expect(CaseIdentifyRegex.isParamCase('get-user-by-id'), isTrue);
        expect(CaseIdentifyRegex.isParamCase('is-active'), isTrue);
        expect(CaseIdentifyRegex.isParamCase('page-404'), isTrue);
      });

      test('should reject invalid param-case', () {
        expect(CaseIdentifyRegex.isParamCase('hello'), isFalse); // Single word
        expect(CaseIdentifyRegex.isParamCase('Hello-World'), isFalse); // Header-Case
        expect(CaseIdentifyRegex.isParamCase('hello_world'), isFalse); // snake_case
        expect(CaseIdentifyRegex.isParamCase('helloWorld'), isFalse); // camelCase
        expect(CaseIdentifyRegex.isParamCase('HELLO-WORLD'), isFalse); // Uppercase
        expect(CaseIdentifyRegex.isParamCase('-hello-world'), isFalse); // Leading dash
        expect(CaseIdentifyRegex.isParamCase('hello-world-'), isFalse); // Trailing dash
        expect(CaseIdentifyRegex.isParamCase(''), isFalse); // Empty
      });
    });

    group('isHeaderCase', () {
      test('should identify valid Header-Case', () {
        expect(CaseIdentifyRegex.isHeaderCase('Hello-World'), isTrue);
        expect(CaseIdentifyRegex.isHeaderCase('Content-Type'), isTrue);
        expect(CaseIdentifyRegex.isHeaderCase('X-Api-Key'), isTrue);
        expect(CaseIdentifyRegex.isHeaderCase('Accept-Language'), isTrue);
        expect(CaseIdentifyRegex.isHeaderCase('User-Agent'), isTrue);
      });

      test('should reject invalid Header-Case', () {
        expect(CaseIdentifyRegex.isHeaderCase('Hello'), isFalse); // Single word
        expect(CaseIdentifyRegex.isHeaderCase('hello-world'), isFalse); // param-case
        expect(CaseIdentifyRegex.isHeaderCase('HELLO-WORLD'), isFalse); // All caps
        expect(CaseIdentifyRegex.isHeaderCase('Hello_World'), isFalse); // Underscore
        expect(CaseIdentifyRegex.isHeaderCase('HelloWorld'), isFalse); // PascalCase
        expect(CaseIdentifyRegex.isHeaderCase('-Hello-World'), isFalse); // Leading dash
        expect(CaseIdentifyRegex.isHeaderCase(''), isFalse); // Empty
      });
    });

    group('isDotCase', () {
      test('should identify valid dot.case', () {
        expect(CaseIdentifyRegex.isDotCase('hello.world'), isTrue);
        expect(CaseIdentifyRegex.isDotCase('my.variable.name'), isTrue);
        expect(CaseIdentifyRegex.isDotCase('com.example.app'), isTrue);
        expect(CaseIdentifyRegex.isDotCase('api.v2.users'), isTrue);
        expect(CaseIdentifyRegex.isDotCase('config.dev.local'), isTrue);
      });

      test('should reject invalid dot.case', () {
        expect(CaseIdentifyRegex.isDotCase('hello'), isFalse); // Single word
        expect(CaseIdentifyRegex.isDotCase('Hello.World'), isFalse); // PascalDotCase
        expect(CaseIdentifyRegex.isDotCase('HELLO.WORLD'), isFalse); // Uppercase
        expect(CaseIdentifyRegex.isDotCase('hello_world'), isFalse); // snake_case
        expect(CaseIdentifyRegex.isDotCase('.hello.world'), isFalse); // Leading dot
        expect(CaseIdentifyRegex.isDotCase('hello.world.'), isFalse); // Trailing dot
        expect(CaseIdentifyRegex.isDotCase(''), isFalse); // Empty
      });
    });

    group('isPascalDotCase', () {
      test('should identify valid Pascal.Dot.Case', () {
        expect(CaseIdentifyRegex.isPascalDotCase('Hello.World'), isTrue);
        expect(CaseIdentifyRegex.isPascalDotCase('My.Class.Name'), isTrue);
        expect(CaseIdentifyRegex.isPascalDotCase('System.IO.File'), isTrue);
        expect(CaseIdentifyRegex.isPascalDotCase('Company.Product.Component'), isTrue);
      });

      test('should reject invalid Pascal.Dot.Case', () {
        expect(CaseIdentifyRegex.isPascalDotCase('Hello'), isFalse); // Single word
        expect(CaseIdentifyRegex.isPascalDotCase('hello.world'), isFalse); // dot.case
        expect(CaseIdentifyRegex.isPascalDotCase('Hello.world'), isFalse); // Mixed
        expect(CaseIdentifyRegex.isPascalDotCase('HELLO.WORLD'), isFalse); // All caps
        expect(CaseIdentifyRegex.isPascalDotCase('HelloWorld'), isFalse); // PascalCase
        expect(CaseIdentifyRegex.isPascalDotCase('.Hello.World'), isFalse); // Leading dot
        expect(CaseIdentifyRegex.isPascalDotCase(''), isFalse); // Empty
      });
    });

    group('isImportCase', () {
      test('should identify valid import case', () {
        expect(CaseIdentifyRegex.isImportCase('package:dartz/dartz.dart'), isTrue);
        expect(CaseIdentifyRegex.isImportCase('package:flutter/material.dart'), isTrue);
        expect(CaseIdentifyRegex.isImportCase('dart:core'), isTrue);
        expect(CaseIdentifyRegex.isImportCase('dart:async'), isTrue);
        expect(CaseIdentifyRegex.isImportCase('package:test/test.dart'), isTrue);
        expect(CaseIdentifyRegex.isImportCase('package:my_app/src/models/user.dart'), isTrue);
      });

      test('should reject invalid import case', () {
        expect(CaseIdentifyRegex.isImportCase('package/dartz/dartz.dart'), isFalse); // No colon
        expect(CaseIdentifyRegex.isImportCase('dartz/dartz.dart'), isFalse); // No package:
        expect(CaseIdentifyRegex.isImportCase('package:'), isFalse); // No path
        expect(CaseIdentifyRegex.isImportCase(':dartz/dartz.dart'), isFalse); // No prefix
        expect(CaseIdentifyRegex.isImportCase(''), isFalse); // Empty
      });
    });

    group('isPathCase', () {
      test('should identify valid path case', () {
        expect(CaseIdentifyRegex.isPathCase('hello/world'), isTrue);
        expect(CaseIdentifyRegex.isPathCase('src/models/user'), isTrue);
        expect(CaseIdentifyRegex.isPathCase('lib/src/core/extensions'), isTrue);
        expect(CaseIdentifyRegex.isPathCase('/home/user/documents'), isTrue);
        expect(CaseIdentifyRegex.isPathCase('path/to/file.dart'), isTrue);
        expect(CaseIdentifyRegex.isPathCase('folder/subfolder/'), isTrue);
        expect(CaseIdentifyRegex.isPathCase('/'), isTrue); // Root path
        expect(CaseIdentifyRegex.isPathCase('/splash'), isTrue);
        expect(CaseIdentifyRegex.isPathCase('/splash.dart'), isTrue);
        expect(CaseIdentifyRegex.isPathCase('/splash.dart/'), isTrue);
        // Windows paths
        expect(CaseIdentifyRegex.isPathCase(r'hello\world'), isTrue);
        expect(CaseIdentifyRegex.isPathCase(r'C:\Users\name'), isTrue);
        expect(CaseIdentifyRegex.isPathCase(r'\Program Files\app'), isTrue);
      });

      test('should reject invalid path case', () {
        expect(CaseIdentifyRegex.isPathCase('hello'), isFalse); // Single word, no slash
        expect(CaseIdentifyRegex.isPathCase('hello world'), isFalse); // Space
        expect(CaseIdentifyRegex.isPathCase(''), isFalse); // Empty
      });
    });

    group('isAnyCase', () {
      test('should identify any valid case', () {
        expect(CaseIdentifyRegex.isAnyCase('helloWorld'), isTrue); // camelCase
        expect(CaseIdentifyRegex.isAnyCase('HelloWorld'), isTrue); // PascalCase
        expect(CaseIdentifyRegex.isAnyCase('hello_world'), isTrue); // snake_case
        expect(CaseIdentifyRegex.isAnyCase('HELLO_WORLD'), isTrue); // CONSTANT_CASE
        expect(CaseIdentifyRegex.isAnyCase('hello-world'), isTrue); // param-case
        expect(CaseIdentifyRegex.isAnyCase('Hello-World'), isTrue); // Header-Case
        expect(CaseIdentifyRegex.isAnyCase('hello.world'), isTrue); // dot.case
        expect(CaseIdentifyRegex.isAnyCase('Hello.World'), isTrue); // Pascal.Dot.Case
        expect(CaseIdentifyRegex.isAnyCase('hello/world'), isTrue); // path/case
        expect(CaseIdentifyRegex.isAnyCase('package:test/test.dart'), isTrue); // import case
      });

      test('should reject strings not matching any case', () {
        expect(CaseIdentifyRegex.isAnyCase('hello'), isFalse); // Single word
        expect(CaseIdentifyRegex.isAnyCase('Hello World'), isFalse); // Space separated
        expect(CaseIdentifyRegex.isAnyCase('123hello'), isFalse); // Invalid start
        expect(CaseIdentifyRegex.isAnyCase(''), isFalse); // Empty
      });
    });
  });
}
