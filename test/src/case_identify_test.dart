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
        expect(
          CaseIdentifyRegex.isCamelCase('HelloWorld'),
          isFalse,
        ); // PascalCase
        expect(
          CaseIdentifyRegex.isCamelCase('hello_world'),
          isFalse,
        ); // snake_case
        expect(
          CaseIdentifyRegex.isCamelCase('hello-world'),
          isFalse,
        ); // param-case
        expect(
          CaseIdentifyRegex.isCamelCase('HELLO_WORLD'),
          isFalse,
        ); // CONSTANT_CASE
        expect(CaseIdentifyRegex.isCamelCase('hello world'), isFalse); // Space
        expect(
          CaseIdentifyRegex.isCamelCase('123hello'),
          isFalse,
        ); // Starts with number
        expect(CaseIdentifyRegex.isCamelCase(''), isFalse); // Empty
        expect(
          CaseIdentifyRegex.isCamelCase('orders.dart'),
          isFalse,
        ); // File with .dart extension
        expect(
          CaseIdentifyRegex.isCamelCase('session_provider.dart'),
          isFalse,
        ); // File with .dart extension
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
        expect(
          CaseIdentifyRegex.isPascalCase('helloWorld'),
          isFalse,
        ); // camelCase
        expect(
          CaseIdentifyRegex.isPascalCase('hello_world'),
          isFalse,
        ); // snake_case
        expect(
          CaseIdentifyRegex.isPascalCase('HELLO_WORLD'),
          isFalse,
        ); // CONSTANT_CASE
        expect(
          CaseIdentifyRegex.isPascalCase('Hello-World'),
          isFalse,
        ); // Header-Case
        expect(
          CaseIdentifyRegex.isPascalCase('123HelloWorld'),
          isFalse,
        ); // Starts with number
        expect(CaseIdentifyRegex.isPascalCase(''), isFalse); // Empty
        expect(
          CaseIdentifyRegex.isPascalCase('orders.dart'),
          isFalse,
        ); // File with .dart extension
        expect(
          CaseIdentifyRegex.isPascalCase('session_provider.dart'),
          isFalse,
        ); // File with .dart extension
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
        expect(
          CaseIdentifyRegex.isSnakeCase('helloWorld'),
          isFalse,
        ); // camelCase
        expect(
          CaseIdentifyRegex.isSnakeCase('HelloWorld'),
          isFalse,
        ); // PascalCase
        expect(
          CaseIdentifyRegex.isSnakeCase('HELLO_WORLD'),
          isFalse,
        ); // CONSTANT_CASE
        expect(
          CaseIdentifyRegex.isSnakeCase('hello-world'),
          isFalse,
        ); // param-case
        expect(
          CaseIdentifyRegex.isSnakeCase('hello_World'),
          isFalse,
        ); // Mixed case
        expect(
          CaseIdentifyRegex.isSnakeCase('_hello_world'),
          isFalse,
        ); // Leading underscore
        expect(
          CaseIdentifyRegex.isSnakeCase('hello_world_'),
          isFalse,
        ); // Trailing underscore
        expect(CaseIdentifyRegex.isSnakeCase(''), isFalse); // Empty
        expect(
          CaseIdentifyRegex.isSnakeCase('orders.dart'),
          isFalse,
        ); // File with .dart extension
        expect(
          CaseIdentifyRegex.isSnakeCase('session_provider.dart'),
          isFalse,
        ); // File with .dart extension
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
        expect(
          CaseIdentifyRegex.isConstantCase('HELLO'),
          isFalse,
        ); // Single word
        expect(
          CaseIdentifyRegex.isConstantCase('hello_world'),
          isFalse,
        ); // lowercase
        expect(
          CaseIdentifyRegex.isConstantCase('Hello_World'),
          isFalse,
        ); // Mixed case
        expect(
          CaseIdentifyRegex.isConstantCase('HELLO-WORLD'),
          isFalse,
        ); // Dash separator
        expect(
          CaseIdentifyRegex.isConstantCase('helloWorld'),
          isFalse,
        ); // camelCase
        expect(
          CaseIdentifyRegex.isConstantCase('_HELLO_WORLD'),
          isFalse,
        ); // Leading underscore
        expect(CaseIdentifyRegex.isConstantCase(''), isFalse); // Empty
        expect(
          CaseIdentifyRegex.isConstantCase('orders.dart'),
          isFalse,
        ); // File with .dart extension
        expect(
          CaseIdentifyRegex.isConstantCase('session_provider.dart'),
          isFalse,
        ); // File with .dart extension
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
        expect(
          CaseIdentifyRegex.isParamCase('Hello-World'),
          isFalse,
        ); // Header-Case
        expect(
          CaseIdentifyRegex.isParamCase('hello_world'),
          isFalse,
        ); // snake_case
        expect(
          CaseIdentifyRegex.isParamCase('helloWorld'),
          isFalse,
        ); // camelCase
        expect(
          CaseIdentifyRegex.isParamCase('HELLO-WORLD'),
          isFalse,
        ); // Uppercase
        expect(
          CaseIdentifyRegex.isParamCase('-hello-world'),
          isFalse,
        ); // Leading dash
        expect(
          CaseIdentifyRegex.isParamCase('hello-world-'),
          isFalse,
        ); // Trailing dash
        expect(CaseIdentifyRegex.isParamCase(''), isFalse); // Empty
        expect(
          CaseIdentifyRegex.isParamCase('orders.dart'),
          isFalse,
        ); // File with .dart extension
        expect(
          CaseIdentifyRegex.isParamCase('session_provider.dart'),
          isFalse,
        ); // File with .dart extension
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
        expect(
          CaseIdentifyRegex.isHeaderCase('hello-world'),
          isFalse,
        ); // param-case
        expect(
          CaseIdentifyRegex.isHeaderCase('HELLO-WORLD'),
          isFalse,
        ); // All caps
        expect(
          CaseIdentifyRegex.isHeaderCase('Hello_World'),
          isFalse,
        ); // Underscore
        expect(
          CaseIdentifyRegex.isHeaderCase('HelloWorld'),
          isFalse,
        ); // PascalCase
        expect(
          CaseIdentifyRegex.isHeaderCase('-Hello-World'),
          isFalse,
        ); // Leading dash
        expect(CaseIdentifyRegex.isHeaderCase(''), isFalse); // Empty
        expect(
          CaseIdentifyRegex.isHeaderCase('orders.dart'),
          isFalse,
        ); // File with .dart extension
        expect(
          CaseIdentifyRegex.isHeaderCase('session_provider.dart'),
          isFalse,
        ); // File with .dart extension
      });
    });

    group('isDotCase', () {
      test('should identify valid dot.case', () {
        expect(CaseIdentifyRegex.isDotCase('hello.world'), isTrue);
        expect(CaseIdentifyRegex.isDotCase('my.variable.name'), isTrue);
        expect(CaseIdentifyRegex.isDotCase('com.example.app'), isTrue);
        expect(CaseIdentifyRegex.isDotCase('api.v2.users'), isTrue);
        expect(CaseIdentifyRegex.isDotCase('config.dev.local'), isTrue);
        expect(
          CaseIdentifyRegex.isDotCase('orders.dart'),
          isTrue,
        ); // File extension is valid dot case
      });

      test('should reject invalid dot.case', () {
        expect(CaseIdentifyRegex.isDotCase('hello'), isFalse); // Single word
        expect(
          CaseIdentifyRegex.isDotCase('Hello.World'),
          isFalse,
        ); // PascalDotCase
        expect(
          CaseIdentifyRegex.isDotCase('HELLO.WORLD'),
          isFalse,
        ); // Uppercase
        expect(
          CaseIdentifyRegex.isDotCase('hello_world'),
          isFalse,
        ); // snake_case
        expect(
          CaseIdentifyRegex.isDotCase('.hello.world'),
          isFalse,
        ); // Leading dot
        expect(
          CaseIdentifyRegex.isDotCase('hello.world.'),
          isFalse,
        ); // Trailing dot
        expect(CaseIdentifyRegex.isDotCase(''), isFalse); // Empty
        expect(
          CaseIdentifyRegex.isDotCase('session_provider.dart'),
          isFalse,
        ); // File with underscore and .dart
        expect(
          CaseIdentifyRegex.isDotCase('note_provider.g.dart'),
          isFalse,
        ); // Generated file with underscore
        expect(
          CaseIdentifyRegex.isDotCase('note_provider.freezed.dart'),
          isFalse,
        ); // Freezed file with underscore
      });
    });

    group('isPascalDotCase', () {
      test('should identify valid Pascal.Dot.Case', () {
        expect(CaseIdentifyRegex.isPascalDotCase('Hello.World'), isTrue);
        expect(CaseIdentifyRegex.isPascalDotCase('My.Class.Name'), isTrue);
        expect(CaseIdentifyRegex.isPascalDotCase('System.IO.File'), isTrue);
        expect(
          CaseIdentifyRegex.isPascalDotCase('Company.Product.Component'),
          isTrue,
        );
      });

      test('should reject invalid Pascal.Dot.Case', () {
        expect(
          CaseIdentifyRegex.isPascalDotCase('Hello'),
          isFalse,
        ); // Single word
        expect(
          CaseIdentifyRegex.isPascalDotCase('hello.world'),
          isFalse,
        ); // dot.case
        expect(
          CaseIdentifyRegex.isPascalDotCase('Hello.world'),
          isFalse,
        ); // Mixed
        expect(
          CaseIdentifyRegex.isPascalDotCase('HELLO.WORLD'),
          isTrue,
        ); // All caps (now allowed)
        expect(
          CaseIdentifyRegex.isPascalDotCase('HelloWorld'),
          isFalse,
        ); // PascalCase
        expect(
          CaseIdentifyRegex.isPascalDotCase('.Hello.World'),
          isFalse,
        ); // Leading dot
        expect(CaseIdentifyRegex.isPascalDotCase(''), isFalse); // Empty
        expect(
          CaseIdentifyRegex.isPascalDotCase('orders.dart'),
          isFalse,
        ); // File with .dart extension
        expect(
          CaseIdentifyRegex.isPascalDotCase('session_provider.dart'),
          isFalse,
        ); // File with .dart extension
      });
    });

    group('isImportCase', () {
      test('should identify valid import case', () {
        expect(
          CaseIdentifyRegex.isImportCase('package:dartz/dartz.dart'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isImportCase(
            'package:scoutbox/data/theme_mode.dart',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isAnyCase('package:scoutbox/data/theme_mode.dart'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isImportCase('package:flutter/material.dart'),
          isTrue,
        );
        expect(CaseIdentifyRegex.isImportCase('dart:core'), isTrue);
        expect(CaseIdentifyRegex.isImportCase('dart:async'), isTrue);
        expect(
          CaseIdentifyRegex.isImportCase('package:test/test.dart'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isImportCase('package:my_app/src/models/user.dart'),
          isTrue,
        );
      });

      test('should reject invalid import case', () {
        expect(
          CaseIdentifyRegex.isImportCase('package/dartz/dartz.dart'),
          isFalse,
        ); // No colon
        expect(
          CaseIdentifyRegex.isImportCase('dartz/dartz.dart'),
          isFalse,
        ); // No package:
        expect(CaseIdentifyRegex.isImportCase('package:'), isFalse); // No path
        expect(
          CaseIdentifyRegex.isImportCase(':dartz/dartz.dart'),
          isFalse,
        ); // No prefix
        expect(CaseIdentifyRegex.isImportCase(''), isFalse); // Empty
        expect(
          CaseIdentifyRegex.isImportCase('orders.dart'),
          isFalse,
        ); // File with .dart extension
        expect(
          CaseIdentifyRegex.isImportCase('session_provider.dart'),
          isFalse,
        ); // File with .dart extension
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
        expect(
          CaseIdentifyRegex.isPathCase('/'),
          isFalse,
        ); // Root path (no alphabetic chars)
        expect(CaseIdentifyRegex.isPathCase('/splash'), isTrue);
        expect(CaseIdentifyRegex.isPathCase('/splash.dart'), isTrue);
        expect(CaseIdentifyRegex.isPathCase('/splash.dart/'), isTrue);
        // Windows paths
        expect(CaseIdentifyRegex.isPathCase(r'hello\world'), isTrue);
        expect(CaseIdentifyRegex.isPathCase(r'C:\Users\name'), isTrue);
        expect(CaseIdentifyRegex.isPathCase(r'\Program Files\app'), isTrue);
      });

      test('should reject invalid path case', () {
        expect(
          CaseIdentifyRegex.isPathCase('hello'),
          isFalse,
        ); // Single word, no slash
        expect(CaseIdentifyRegex.isPathCase('hello world'), isFalse); // Space
        expect(CaseIdentifyRegex.isPathCase(''), isFalse); // Empty
        expect(
          CaseIdentifyRegex.isPathCase('orders.dart'),
          isFalse,
        ); // File with .dart extension but no path
        expect(
          CaseIdentifyRegex.isPathCase('session_provider.dart'),
          isFalse,
        ); // File with .dart extension but no path
        expect(
          CaseIdentifyRegex.isPathCase('../data/notification_custom.dart'),
          isFalse,
        ); // Relative path with ..
        expect(
          CaseIdentifyRegex.isPathCase('../states/selection_state.dart'),
          isFalse,
        ); // Relative path with ..
        expect(
          CaseIdentifyRegex.isPathCase('all/\$path/tumb.png'),
          isFalse,
        ); // Path with dollar variable
        expect(
          CaseIdentifyRegex.isPathCase('/all/\$path/tumb.png'),
          isFalse,
        ); // Absolute path with dollar variable
        expect(
          CaseIdentifyRegex.isPathCase('posts/\$id/video.mp4'),
          isFalse,
        ); // Path with dollar variable
      });
    });

    group('isAnyCase', () {
      test('should identify any valid case', () {
        expect(CaseIdentifyRegex.isAnyCase('helloWorld'), isTrue); // camelCase
        expect(CaseIdentifyRegex.isAnyCase('HelloWorld'), isTrue); // PascalCase
        expect(
          CaseIdentifyRegex.isAnyCase('hello_world'),
          isTrue,
        ); // snake_case
        expect(
          CaseIdentifyRegex.isAnyCase('HELLO_WORLD'),
          isTrue,
        ); // CONSTANT_CASE
        expect(
          CaseIdentifyRegex.isAnyCase('hello-world'),
          isTrue,
        ); // param-case
        expect(
          CaseIdentifyRegex.isAnyCase('Hello-World'),
          isTrue,
        ); // Header-Case
        expect(CaseIdentifyRegex.isAnyCase('hello.world'), isTrue); // dot.case
        expect(
          CaseIdentifyRegex.isAnyCase('Hello.World'),
          isTrue,
        ); // Pascal.Dot.Case
        expect(CaseIdentifyRegex.isAnyCase('hello/world'), isTrue); // path/case
        expect(
          CaseIdentifyRegex.isAnyCase('package:test/test'),
          isTrue,
        ); // import case (without .dart extension)
      });
    });

    group('containsBase64', () {
      test('should detect PEM format certificates', () {
        const certificate = '''-----BEGIN CERTIFICATE-----
MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
-----END CERTIFICATE-----''';
        expect(CaseIdentifyRegex.containsBase64(certificate), isTrue);
      });

      test('should detect private keys', () {
        expect(
          CaseIdentifyRegex.containsBase64(
            '-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKcwgg\n-----END PRIVATE KEY-----',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsBase64(
            '-----BEGIN RSA PRIVATE KEY-----\nkey data\n-----END RSA PRIVATE KEY-----',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsBase64(
            '-----BEGIN EC PRIVATE KEY-----\nkey data\n-----END EC PRIVATE KEY-----',
          ),
          isTrue,
        );
      });

      test('should detect long base64 sequences', () {
        // Real base64 encoded data
        expect(
          CaseIdentifyRegex.containsBase64(
            'SGVsbG8gV29ybGQhIFRoaXMgaXMgYSBsb25nZXIgc3RyaW5nIGVuY29kZWQgaW4gYmFzZTY0',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsBase64(
            'eyJuYW1lIjoiSm9obiIsImFnZSI6MzAsImNpdHkiOiJOZXcgWW9yayJ9',
          ),
          isTrue,
        );
      });

      test('should not detect normal text as base64', () {
        expect(CaseIdentifyRegex.containsBase64('Hello World'), isFalse);
        expect(
          CaseIdentifyRegex.containsBase64(
            'This is a normal sentence with spaces',
          ),
          isFalse,
        );
        expect(CaseIdentifyRegex.containsBase64('camelCaseVariable'), isFalse);
        expect(
          CaseIdentifyRegex.containsBase64('snake_case_variable'),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.containsBase64('CONSTANT_CASE_VARIABLE'),
          isFalse,
        );
      });

      test('should not detect short alphanumeric sequences as base64', () {
        expect(CaseIdentifyRegex.containsBase64('ABC123'), isFalse);
        expect(CaseIdentifyRegex.containsBase64('shortString'), isFalse);
        expect(CaseIdentifyRegex.containsBase64('Test1234567890'), isFalse);
      });

      test('should not detect sequences with mostly one character type', () {
        // All lowercase
        expect(
          CaseIdentifyRegex.containsBase64(
            'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz',
          ),
          isFalse,
        );
        // All uppercase
        expect(
          CaseIdentifyRegex.containsBase64(
            'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ',
          ),
          isFalse,
        );
        // All numbers
        expect(
          CaseIdentifyRegex.containsBase64(
            '123456789012345678901234567890123456789012345678901234567890',
          ),
          isFalse,
        );
      });

      test('should handle the provided certificate example', () {
        const amazonRootCaPem = '''
-----BEGIN CERTIFICATE-----
MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
b24gUm9vdCBDQSAxMB4XDTE1MDUyNjAwMDAwMFoXDTM4MDExNzAwMDAwMFowOTEL
MAkGA1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJv
b3QgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALJ4gHHKeNXj
ca9HgFB0fW7Y14h29Jlo91ghYPl0hAEvrAIthtOgQ3pOsqTQNroBvo3bSMgHFzZM
9O6II8c+6zf1tRn4SWiw3te5djgdYZ6k/oI2peVKVuRF4fn9tBb6dNqcmzU5L/qw
IFAGbHrQgLKm+a/sRxmPUDgH3KKHOVj4utWp+UhnMJbulHheb4mjUcAwhmahRWa6
VOujw5H5SNz/0egwLX0tdHA114gk957EWW67c4cX8jJGKLhD+rcdqsq08p8kDi1L
93FcXmn/6pUCyziKrlA4b9v7LWIbxcceVOF34GfID5yHI9Y/QCB/IIDEgEw+OyQm
jgSubJrIqg0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
AYYwHQYDVR0OBBYEFIQYzIU07LwMlJQuCFmcx7IQTgoIMA0GCSqGSIb3DQEBCwUA
A4IBAQCY8jdaQZChGsV2USggNiMOruYou6r4lK5IpDB/G/wkjUu0yKGX9rbxenDI
U5PMCCjjmCXPI6T53iHTfIUJrU6adTrCC2qJeHZERxhlbI1Bjjt/msv0tadQ1wUs
N+gDS63pYaACbvXy8MWy7Vu33PqUXHeeE6V/Uq2V8viTO96LXFvKWlJbYK8U90vv
o/ufQJVtMVT8QtPHRh8jrdkPSHCa2XV4cdFyQzR1bldZwgJcJmApzyMZFo6IQ6XU
5MsI+yMRQ+hDKXJioaldXgjUkK642M4UwtBV8ob2xJNDd2ZhwLnoQdeXeGADbkpy
rqXRfboQnoZsG4q5WTP468SQvvG5
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIFQTCCAymgAwIBAgITBmyf0pY1hp8KD+WGePhbJruKNzANBgkqhkiG9w0BAQwF
ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
b24gUm9vdCBDQSAyMB4XDTE1MDUyNjAwMDAwMFoXDTQwMDUyNjAwMDAwMFowOTEL
MAkGA1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJv
b3QgQ0EgMjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAK2Wny2cSkxK
gXlRmeyKy2tgURO8TW0G/LAIjd0ZEGrHJgw12MBvIITplLGbhQPDW9tK6Mj4kHbZ
W0/jTOgGNk3Mmqw9DJArktQGGWCsN0R5hYGCrVo34A3MnaZMUnbqQ523BNFQ9lXg
1dKmSYXpN+nKfq5clU1Imj+uIFptiJXZNLhSGkOQsL9sBbm2eLfq0OQ6PBJTYv9K
8nu+NQWpEjTj82R0Yiw9AElaKP4yRLuH3WUnAnE72kr3H9rN9yFVkE8P7K6C4Z9r
2UXTu/Bfh+08LDmG2j/e7HJV63mjrdvdfLC6HM783k81ds8P+HgfajZRRidhW+me
z/CiVX18JYpvL7TFz4QuK/0NURBs+18bvBt+xa47mAExkv8LV/SasrlX6avvDXbR
8O70zoan4G7ptGmh32n2M8ZpLpcTnqWHsFcQgTfJU7O7f/aS0ZzQGPSSbtqDT6Zj
mUyl+17vIWR6IF9sZIUVyzfpYgwLKhbcAS4y2j5L9Z469hdAlO+ekQiG+r5jqFoz
7Mt0Q5X5bGlSNscpb/xVA1wf+5+9R+vnSUeVC06JIglJ4PVhHvG/LopyboBZ/1c6
+XUyo05f7O0oYtlNc/LMgRdg7c3r3NunysV+Ar3yVAhU/bQtCSwXVEqY0VThUWcI
0u1ufm8/0i2BWSlmy5A5lREedCf+3euvAgMBAAGjQjBAMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgGGMB0GA1UdDgQWBBSwDPBMMPQFWAJI/TPlUq9LhONm
UjANBgkqhkiG9w0BAQwFAAOCAgEAqqiAjw54o+Ci1M3m9Zh6O+oAA7CXDpO8Wqj2
LIxyh6mx/H9z/WNxeKWHWc8w4Q0QshNabYL1auaAn6AFC2jkR2vHat+2/XcycuUY
+gn0oJMsXdKMdYV2ZZAMA3m3MSNjrXiDCYZohMr/+c8mmpJ5581LxedhpxfL86kS
k5Nrp+gvU5LEYFiwzAJRGFuFjWJZY7attN6a+yb3ACfAXVU3dJnJUH/jWS5E4ywl
7uxMMne0nxrpS10gxdr9HIcWxkPo1LsmmkVwXqkLN1PiRnsn/eBG8om3zEK2yygm
btmlyTrIQRNg91CMFa6ybRoVGld45pIq2WWQgj9sAq+uEjonljYE1x2igGOpm/Hl
urR8FLBOybEfdF849lHqm/osohHUqS0nGkWxr7JOcQ3AWEbWaQbLU8uz/mtBzUF+
fUwPfHJ5elnNXkoOrJupmHN5fLT0zLm4BwyydFy4x2+IoZCn9Kr5v2c69BoVYh63
n749sSmvZ6ES8lgQGVMDMBu4Gon2nL2XA46jCfMdiyHxtN/kHNGfZQIG6lzWE7OE
76KlXIx3KadowGuuQNKotOrN8I1LOJwZmhsoVLiJkO/KdYE+HvJkJMcYr07/R54H
9jVlpNMKVv/1F2Rs76giJUmTtt8AF9pYfl3uxRuw0dFfIRDH+fO6AgonB8Xx1sfT
4PsJYGw=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIBtjCCAVugAwIBAgITBmyf1XSXNmY/Owua2eiedgPySjAKBggqhkjOPQQDAjA5
MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6b24g
Um9vdCBDQSAzMB4XDTE1MDUyNjAwMDAwMFoXDTQwMDUyNjAwMDAwMFowOTELMAkG
A1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJvb3Qg
Q0EgMzBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABCmXp8ZBf8ANm+gBG1bG8lKl
ui2yEujSLtf6ycXYqm0fc4E7O5hrOXwzpcVOho6AF2hiRVd9RFgdszflZwjrZt6j
QjBAMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgGGMB0GA1UdDgQWBBSr
ttvXBp43rDCGB5Fwx5zEGbF4wDAKBggqhkjOPQQDAgNJADBGAiEA4IWSoxe3jfkr
BqWTrBqYaGFy+uGh0PsceGCmQ5nFuMQCIQCcAu/xlJyzlvnrxir4tiz+OpAUFteM
YyRIHN8wfdVoOw==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIB8jCCAXigAwIBAgITBmyf18G7EEwpQ+Vxe3ssyBrBDjAKBggqhkjOPQQDAzA5
MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6b24g
Um9vdCBDQSA0MB4XDTE1MDUyNjAwMDAwMFoXDTQwMDUyNjAwMDAwMFowOTELMAkG
A1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJvb3Qg
Q0EgNDB2MBAGByqGSM49AgEGBSuBBAAiA2IABNKrijdPo1MN/sGKe0uoe0ZLY7Bi
9i0b2whxIdIA6GO9mif78DluXeo9pcmBqqNbIJhFXRbb/egQbeOc4OO9X4Ri83Bk
M6DLJC9wuoihKqB1+IGuYgbEgds5bimwHvouXKNCMEAwDwYDVR0TAQH/BAUwAwEB
/zAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0OBBYEFNPsxzplbszh2naaVvuc84ZtV+WB
MAoGCCqGSM49BAMDA2gAMGUCMDqLIfG9fhGt0O9Yli/W651+kI0rz2ZVwyzjKKlw
CkcO8DdZEv8tmZQoTipPNU0zWgIxAOp1AE47xDqUEpHJWEadIRNyp4iciuRMStuW
1KyLa2tJElMzrdfkviT8tQp21KW8EA==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIID7zCCAtegAwIBAgIBADANBgkqhkiG9w0BAQsFADCBmDELMAkGA1UEBhMCVVMx
EDAOBgNVBAgTB0FyaXpvbmExEzARBgNVBAcTClNjb3R0c2RhbGUxJTAjBgNVBAoT
HFN0YXJmaWVsZCBUZWNobm9sb2dpZXMsIEluYy4xOzA5BgNVBAMTMlN0YXJmaWVs
ZCBTZXJ2aWNlcyBSb290IENlcnRpZmljYXRlIEF1dGhvcml0eSAtIEcyMB4XDTA5
MDkwMTAwMDAwMFoXDTM3MTIzMTIzNTk1OVowgZgxCzAJBgNVBAYTAlVTMRAwDgYD
VQQIEwdBcml6b25hMRMwEQYDVQQHEwpTY290dHNkYWxlMSUwIwYDVQQKExxTdGFy
ZmllbGQgVGVjaG5vbG9naWVzLCBJbmMuMTswOQYDVQQDEzJTdGFyZmllbGQgU2Vy
dmljZXMgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgLSBHMjCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBANUMOsQq+U7i9b4Zl1+OiFOxHz/Lz58gE20p
OsgPfTz3a3Y4Y9k2YKibXlwAgLIvWX/2h/klQ4bnaRtSmpDhcePYLQ1Ob/bISdm2
8xpWriu2dBTrz/sm4xq6HZYuajtYlIlHVv8loJNwU4PahHQUw2eeBGg6345AWh1K
Ts9DkTvnVtYAcMtS7nt9rjrnvDH5RfbCYM8TWQIrgMw0R9+53pBlbQLPLJGmpufe
hRhJfGZOozptqbXuNC66DQO4M99H67FrjSXZm86B0UVGMpZwh94CDklDhbZsc7tk
6mFBrMnUVN+HL8cisibMn1lUaJ/8viovxFUcdUBgF4UCVTmLfwUCAwEAAaNCMEAw
DwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFJxfAN+q
AdcwKziIorhtSpzyEZGDMA0GCSqGSIb3DQEBCwUAA4IBAQBLNqaEd2ndOxmfZyMI
bw5hyf2E3F/YNoHN2BtBLZ9g3ccaaNnRbobhiCPPE95Dz+I0swSdHynVv/heyNXB
ve6SbzJ08pGCL72CQnqtKrcgfU28elUSwhXqvfdqlS5sdJ/PHLTyxQGjhdByPq1z
qwubdQxtRbeOlKyWN7Wg0I8VRw7j6IPdj/3vQQF3zCepYoUz8jcI73HPdwbeyBkd
iEDPfUYd/x7H4c7/I9vG+o1VTqkC50cRRj70/b17KSa7qWFiNyi2LSr2EIZkyXCn
0q23KXB56jzaYyWf/Wi3MOxw+3WKt21gZ7IeyLnp2KhvAotnDU0mV3HaIPzBSlCN
sSi6
-----END CERTIFICATE-----
''';
        expect(CaseIdentifyRegex.containsBase64(amazonRootCaPem), isTrue);
        expect(CaseIdentifyRegex.isAnyCase(amazonRootCaPem), isTrue);
      });
    });

    group('containsSha1Key', () {
      test('should detect SHA1 hashes', () {
        // Real SHA1 hashes
        expect(
          CaseIdentifyRegex.containsSha1Key(
            '2fd4e1c67a2d28fced849ee1bb76e7391b93eb12',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsSha1Key(
            'da39a3ee5e6b4b0d3255bfef95601890afd80709',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsSha1Key(
            'SHA1: 356a192b7913b04c54574d18c28d46e6395428ab',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsSha1Key(
            '"hash": "5d41402abc4b2a76b9719d911017c592"',
          ),
          isFalse,
        ); // Too short (MD5)
        expect(
          CaseIdentifyRegex.containsSha1Key(
            'The SHA1 is: aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d',
          ),
          isTrue,
        );
      });

      test('should not detect normal text as SHA1', () {
        expect(CaseIdentifyRegex.containsSha1Key('Hello World'), isFalse);
        expect(
          CaseIdentifyRegex.containsSha1Key('This is a normal sentence'),
          isFalse,
        );
        expect(CaseIdentifyRegex.containsSha1Key('1234567890'), isFalse);
        expect(CaseIdentifyRegex.containsSha1Key('abcdefghijklmnop'), isFalse);
      });

      test('should not detect repetitive patterns as SHA1', () {
        expect(
          CaseIdentifyRegex.containsSha1Key(
            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
          ),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.containsSha1Key(
            '0000000000000000000000000000000000000000',
          ),
          isFalse,
        );
      });

      test('should not confuse with longer hex strings', () {
        // SHA256 hash (64 chars) should not be detected as SHA1
        expect(
          CaseIdentifyRegex.containsSha1Key(
            'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
          ),
          isFalse,
        );
      });
    });

    group('containsSha256Key', () {
      test('should detect SHA256 hashes', () {
        expect(
          CaseIdentifyRegex.containsSha256Key(
            'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsSha256Key(
            'SHA256:d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsSha256Key(
            '"checksum": "a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3"',
          ),
          isTrue,
        );
      });

      test('should not detect normal text as SHA256', () {
        expect(CaseIdentifyRegex.containsSha256Key('Hello World'), isFalse);
        expect(
          CaseIdentifyRegex.containsSha256Key(
            'This is a longer sentence with more characters',
          ),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.containsSha256Key('1234567890abcdef'),
          isFalse,
        ); // Too short
      });

      test('should not detect SHA1 as SHA256', () {
        expect(
          CaseIdentifyRegex.containsSha256Key(
            '2fd4e1c67a2d28fced849ee1bb76e7391b93eb12',
          ),
          isFalse,
        ); // 40 chars
      });
    });

    group('containsSha512Key', () {
      test('should detect SHA512 hashes', () {
        const sha512 =
            'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e';
        expect(CaseIdentifyRegex.containsSha512Key(sha512), isTrue);
        expect(CaseIdentifyRegex.containsSha512Key('SHA512: $sha512'), isTrue);
      });

      test('should not detect shorter hashes as SHA512', () {
        expect(
          CaseIdentifyRegex.containsSha512Key(
            'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
          ),
          isFalse,
        ); // SHA256
        expect(
          CaseIdentifyRegex.containsSha512Key(
            '2fd4e1c67a2d28fced849ee1bb76e7391b93eb12',
          ),
          isFalse,
        ); // SHA1
      });

      test('should not detect normal text', () {
        expect(
          CaseIdentifyRegex.containsSha512Key(
            'This is a very long sentence but it is not a SHA512 hash',
          ),
          isFalse,
        );
      });
    });

    group('containsSha2Key', () {
      test('should detect all SHA2 family hashes', () {
        // SHA224 (56 hex)
        expect(
          CaseIdentifyRegex.containsSha2Key(
            'd14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f',
          ),
          isTrue,
        );
        // SHA256 (64 hex)
        expect(
          CaseIdentifyRegex.containsSha2Key(
            'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
          ),
          isTrue,
        );
        // SHA384 (96 hex)
        expect(
          CaseIdentifyRegex.containsSha2Key(
            '38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b',
          ),
          isTrue,
        );
        // SHA512 (128 hex)
        expect(
          CaseIdentifyRegex.containsSha2Key(
            'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e',
          ),
          isTrue,
        );
      });

      test('should not detect SHA1 as SHA2', () {
        expect(
          CaseIdentifyRegex.containsSha2Key(
            '2fd4e1c67a2d28fced849ee1bb76e7391b93eb12',
          ),
          isFalse,
        );
      });

      test('should not detect normal text', () {
        expect(CaseIdentifyRegex.containsSha2Key('Hello World'), isFalse);
      });
    });

    group('containsRSAKey', () {
      test('should detect SSH RSA keys', () {
        expect(
          CaseIdentifyRegex.containsRSAKey(
            'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsRSAKey(
            'ssh-rsa AAAAB3NzaC1yc2E= user@host',
          ),
          isTrue,
        );
      });

      test('should detect JWK RSA keys', () {
        expect(
          CaseIdentifyRegex.containsRSAKey(
            '{"kty":"RSA","n":"0vx7agoebGcQSuuPiLJXZptN9nndrQmbXEps2aiAFbWhM78LhWx4cbbfAAtV"}',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsRSAKey('{"kty": "RSA", "use": "sig"}'),
          isTrue,
        );
      });

      test('should detect RSA key components in JSON', () {
        expect(CaseIdentifyRegex.containsRSAKey('"modulus": "AQA..."'), isTrue);
        expect(
          CaseIdentifyRegex.containsRSAKey('"publicExponent": "AQAB"'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsRSAKey('"privateExponent": "..."'),
          isTrue,
        );
      });

      test('should detect PEM RSA headers', () {
        expect(
          CaseIdentifyRegex.containsRSAKey('-----BEGIN RSA PRIVATE KEY-----'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsRSAKey('-----BEGIN RSA PUBLIC KEY-----'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsRSAKey('-----BEGIN PUBLIC KEY-----'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsRSAKey('-----BEGIN PRIVATE KEY-----'),
          isTrue,
        );
      });

      test('should detect very long hex sequences (RSA modulus)', () {
        final longHex = 'a' * 512; // 512 hex chars (2048 bits)
        expect(CaseIdentifyRegex.containsRSAKey(longHex), isTrue);
      });

      test('should not detect normal text as RSA', () {
        expect(CaseIdentifyRegex.containsRSAKey('Hello World'), isFalse);
        expect(
          CaseIdentifyRegex.containsRSAKey('This is a normal sentence'),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.containsRSAKey('public key authentication'),
          isFalse,
        ); // Contains "public key" but in normal context
      });
    });

    group('isAnyCase with cryptographic content', () {
      test('should accept strings containing SHA1', () {
        expect(
          CaseIdentifyRegex.isAnyCase(
            'api_key: 2fd4e1c67a2d28fced849ee1bb76e7391b93eb12',
          ),
          isTrue,
        );
      });

      test('should accept strings containing SHA256', () {
        expect(
          CaseIdentifyRegex.isAnyCase(
            'checksum: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
          ),
          isTrue,
        );
      });

      test('should accept strings containing SHA512', () {
        const sha512 =
            'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e';
        expect(CaseIdentifyRegex.isAnyCase('hash=$sha512'), isTrue);
      });

      test('should accept strings containing RSA keys', () {
        expect(
          CaseIdentifyRegex.isAnyCase('ssh-rsa AAAAB3NzaC1yc2E= user@host'),
          isTrue,
        );
        expect(CaseIdentifyRegex.isAnyCase('{"kty":"RSA","n":"..."}'), isTrue);
      });

      test(
        'should accept normal case strings without cryptographic content',
        () {
          expect(
            CaseIdentifyRegex.isAnyCase('helloWorld'),
            isTrue,
          ); // camelCase
          expect(
            CaseIdentifyRegex.isAnyCase('hello_world'),
            isTrue,
          ); // snake_case
          expect(
            CaseIdentifyRegex.isAnyCase('HELLO_WORLD'),
            isTrue,
          ); // CONSTANT_CASE
        },
      );
    });

    group('containsMD5Hash', () {
      test('should detect MD5 hashes', () {
        expect(
          CaseIdentifyRegex.containsMD5Hash('5d41402abc4b2a76b9719d911017c592'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsMD5Hash('098f6bcd4621d373cade4e832627b4f6'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsMD5Hash(
            'MD5: 5d41402abc4b2a76b9719d911017c592',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsMD5Hash(
            '"hash": "098f6bcd4621d373cade4e832627b4f6"',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsMD5Hash(
            'The MD5 checksum is 21232f297a57a5a743894a0e4a801fc3',
          ),
          isTrue,
        );
      });

      test('should not detect normal text as MD5', () {
        expect(CaseIdentifyRegex.containsMD5Hash('Hello World'), isFalse);
        expect(CaseIdentifyRegex.containsMD5Hash('This is a test'), isFalse);
        expect(CaseIdentifyRegex.containsMD5Hash('12345678'), isFalse);
        expect(CaseIdentifyRegex.containsMD5Hash('abcdefgh'), isFalse);
      });

      test('should not detect repetitive patterns as MD5', () {
        expect(
          CaseIdentifyRegex.containsMD5Hash('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.containsMD5Hash('00000000000000000000000000000000'),
          isFalse,
        );
      });

      test('should not confuse with longer hashes', () {
        // Should not match part of SHA1 (40 chars)
        expect(
          CaseIdentifyRegex.containsMD5Hash(
            '2fd4e1c67a2d28fced849ee1bb76e7391b93eb12',
          ),
          isFalse,
        );
        // Should not match part of SHA256 (64 chars)
        expect(
          CaseIdentifyRegex.containsMD5Hash(
            'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
          ),
          isFalse,
        );
      });

      test('should detect 32 hex chars as potential MD5', () {
        // Note: 32 hex chars could be either MD5 or UUID without dashes
        // The containsUUID function uses context to distinguish them
        expect(
          CaseIdentifyRegex.containsMD5Hash('550e8400e29b41d4a716446655440000'),
          isTrue,
        );
        // But with uuid context, containsUUID should also detect it
        expect(
          CaseIdentifyRegex.containsUUID(
            'uuid: 550e8400e29b41d4a716446655440000',
          ),
          isTrue,
        );
      });
    });

    group('containsJWT', () {
      test('should detect valid JWTs', () {
        const jwt1 =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
        expect(CaseIdentifyRegex.containsJWT(jwt1), isTrue);

        const jwt2 =
            'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.POstGetfAytaZS82wHcjoTyoqhMyxXiWdR7Nn7A29DNSl0EiXLdwJ6xC6AfgZWF1bOsS_TuYI3OG85AmiExREkrS6tDfTQ2B3WXlrr-wp5AokiRbz3_oB4OxG-W9KcEEbDRcZc0nH3L7LzYptiy1PtAylQGxHTWZXtGz4ht0bAecBgmpdgXMguEIcoqPJ1n3pIWk_dUZegpqx0Lka21H6XxUTxiy8OcaarA8zdnPUnV6AmNP3ecFawIFYdvJB_cm-GvpCSbr8G8y_Mllj8f4x9nBH8pQux89_6gUY618iYv7tuPWBFfEbLxtF2pZS6YC1aSfLQxeNe8djT9YjpvRZA';
        expect(CaseIdentifyRegex.containsJWT(jwt2), isTrue);

        expect(
          CaseIdentifyRegex.containsJWT('Authorization: Bearer $jwt1'),
          isTrue,
        );
        expect(CaseIdentifyRegex.containsJWT('"token": "$jwt1"'), isTrue);
      });

      test('should not detect non-JWT three-part strings', () {
        expect(
          CaseIdentifyRegex.containsJWT('hello.world.test'),
          isFalse,
        ); // Too short
        expect(
          CaseIdentifyRegex.containsJWT('AAAA.BBBB.CCCC'),
          isFalse,
        ); // No character variety
        expect(
          CaseIdentifyRegex.containsJWT('version.1.0'),
          isFalse,
        ); // Too short
        expect(
          CaseIdentifyRegex.containsJWT('path.to.file'),
          isFalse,
        ); // Too short
      });

      test('should not detect normal text as JWT', () {
        expect(CaseIdentifyRegex.containsJWT('Hello World'), isFalse);
        expect(
          CaseIdentifyRegex.containsJWT('This is a sentence with dots.'),
          isFalse,
        );
        expect(CaseIdentifyRegex.containsJWT('email@example.com'), isFalse);
      });
    });

    group('containsUUID', () {
      test('should detect standard format UUIDs', () {
        expect(
          CaseIdentifyRegex.containsUUID(
            '550e8400-e29b-41d4-a716-446655440000',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsUUID(
            '6ba7b810-9dad-11d1-80b4-00c04fd430c8',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsUUID(
            'id: 550e8400-e29b-41d4-a716-446655440000',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsUUID(
            '"uuid": "6ba7b810-9dad-11d1-80b4-00c04fd430c8"',
          ),
          isTrue,
        );
      });

      test('should detect UUIDs without dashes in context', () {
        expect(
          CaseIdentifyRegex.containsUUID(
            'uuid: 550e8400e29b41d4a716446655440000',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsUUID(
            'guid=6ba7b8109dad11d180b400c04fd430c8',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsUUID(
            'id: "550e8400e29b41d4a716446655440000"',
          ),
          isTrue,
        );
      });

      test('should not detect 32 hex chars without UUID context', () {
        // Without uuid/guid/id context, 32 hex chars alone shouldn't match
        expect(
          CaseIdentifyRegex.containsUUID('550e8400e29b41d4a716446655440000'),
          isFalse,
        );
        // MD5 hash should not be detected as UUID
        expect(
          CaseIdentifyRegex.containsUUID('5d41402abc4b2a76b9719d911017c592'),
          isFalse,
        );
      });

      test('should not detect normal text as UUID', () {
        expect(CaseIdentifyRegex.containsUUID('Hello World'), isFalse);
        expect(
          CaseIdentifyRegex.containsUUID(
            '12345678-1234-1234-1234-123456789012',
          ),
          isTrue,
        ); // Valid UUID format (v1/v4 can have all numbers)
        expect(CaseIdentifyRegex.containsUUID('this-is-not-a-uuid'), isFalse);
      });

      test('should handle uppercase and lowercase UUIDs', () {
        expect(
          CaseIdentifyRegex.containsUUID(
            '550E8400-E29B-41D4-A716-446655440000',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsUUID(
            '550e8400-E29B-41d4-A716-446655440000',
          ),
          isTrue,
        ); // Mixed case
      });
    });

    group('isSuspectToNotBeUserFacingString', () {
      test('should return false for strings less than 50 characters', () {
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString('short string'),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            'no spaces needed here',
          ),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString('a' * 49),
          isFalse,
        );
      });

      test('should return false for empty string', () {
        expect(CaseIdentifyRegex.isSuspectToNotBeUserFacingString(''), isFalse);
      });

      test('should return true for 50+ char strings without enough spaces', () {
        // 50 chars, needs 1 space, has 0
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString('a' * 50),
          isTrue,
        );

        // 100 chars, needs 2 spaces, has 1
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            '${'a' * 49} ${'b' * 50}',
          ),
          isTrue,
        );

        // 250 chars, needs 5 spaces, has 0
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString('a' * 250),
          isTrue,
        );
      });

      test('should return false for strings with enough spaces', () {
        // 50 chars, needs 1 space, has 1
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            '${'a' * 25} ${'b' * 24}',
          ),
          isFalse,
        );

        // 100 chars, needs 2 spaces, has 2
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            'This is a normal sentence that has enough spaces for the length requirement okay',
          ),
          isFalse,
        );

        // 250 chars, needs 5 spaces, has 5+
        const longUserFriendlyString =
            'This is a much longer piece of text that represents '
            'what a user facing string might look like in a real application. '
            'It has proper spacing and punctuation to make it readable. '
            'This kind of string would be displayed to users in the interface.';
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            longUserFriendlyString,
          ),
          isFalse,
        );
      });

      test('should correctly identify keys and tokens as suspect', () {
        // Base64-like string without spaces
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            'YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXowMTIzNDU2Nzg5YWJjZGVmZ2hpams=',
          ),
          isTrue,
        );

        // Long hex string (like a hash)
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            'a1b2c3d4e5f6789012345678901234567890abcdef1234567890abcdef123456',
          ),
          isTrue,
        );

        // JWT-like string
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ',
          ),
          isTrue,
        );
      });

      test('should handle edge cases correctly', () {
        // Exactly 50 chars with 1 space
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            '${'a' * 24} ${'b' * 25}',
          ),
          isFalse,
        );

        // 51 chars still needs only 1 space
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            '${'a' * 25} ${'b' * 25}',
          ),
          isFalse,
        );

        // 99 chars still needs only 1 space
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            '${'a' * 49} ${'b' * 49}',
          ),
          isFalse,
        );

        // 100 chars needs 2 spaces
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            '${'a' * 49} ${'b' * 50}',
          ),
          isTrue,
        ); // only has 1
        expect(
          CaseIdentifyRegex.isSuspectToNotBeUserFacingString(
            '${'a' * 48} ${'b' * 49} c',
          ),
          isFalse,
        ); // has 2
      });
    });

    group('containsFileReference', () {
      test('should detect Dart files', () {
        expect(
          CaseIdentifyRegex.containsFileReference('player_styles.dart'),
          isTrue,
        );
        expect(CaseIdentifyRegex.containsFileReference('main.dart'), isTrue);
        expect(
          CaseIdentifyRegex.containsFileReference('path/to/file.dart'),
          isTrue,
        );
      });

      test('should detect generated Dart files', () {
        expect(
          CaseIdentifyRegex.containsFileReference(
            'subscriber_entries.freezed.dart',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsFileReference('subscriber_entries.g.dart'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsFileReference('player_level.pb.dart'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsFileReference('service.pbenum.dart'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsFileReference('service.pbgrpc.dart'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsFileReference('service.pbjson.dart'),
          isTrue,
        );
      });

      test('should detect package imports with file extensions', () {
        expect(
          CaseIdentifyRegex.containsFileReference(
            'package:flutter/material.dart',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.containsFileReference(
            'package:dsf_ms_proto/proto/dreamstock/dsf_ms_scout/v3/player_level.pb.dart',
          ),
          isTrue,
        );
        // Package imports without extensions should not be detected as file references
        expect(
          CaseIdentifyRegex.containsFileReference('package:test/test'),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.containsFileReference('package:flutter/material'),
          isFalse,
        );
      });

      test('should detect other programming file extensions', () {
        expect(CaseIdentifyRegex.containsFileReference('script.js'), isTrue);
        expect(CaseIdentifyRegex.containsFileReference('app.py'), isTrue);
        expect(CaseIdentifyRegex.containsFileReference('config.json'), isTrue);
        expect(
          CaseIdentifyRegex.containsFileReference('styles.css'),
          isFalse,
        ); // Not in our list
        expect(
          CaseIdentifyRegex.containsFileReference('index.html'),
          isFalse,
        ); // Not in our list
      });

      test('should not detect normal text as file references', () {
        expect(CaseIdentifyRegex.containsFileReference('Hello World'), isFalse);
        expect(
          CaseIdentifyRegex.containsFileReference('This is a sentence.'),
          isFalse,
        );
        expect(CaseIdentifyRegex.containsFileReference('user_name'), isFalse);
        expect(
          CaseIdentifyRegex.containsFileReference('player_score'),
          isFalse,
        );
      });

      test('should handle edge cases', () {
        expect(
          CaseIdentifyRegex.containsFileReference('.dart'),
          isTrue,
        ); // Just extension
        expect(
          CaseIdentifyRegex.containsFileReference('dart'),
          isFalse,
        ); // Without dot
        expect(
          CaseIdentifyRegex.containsFileReference('file.dart.txt'),
          isTrue,
        ); // .txt at end
        expect(
          CaseIdentifyRegex.containsFileReference('package:'),
          isFalse,
        ); // Just package: without file extension
      });
    });

    group('isAnyCase with MD5, JWT, UUID', () {
      test('should accept strings containing MD5', () {
        expect(
          CaseIdentifyRegex.isAnyCase(
            'checksum: 5d41402abc4b2a76b9719d911017c592',
          ),
          isTrue,
        );
      });

      test('should accept strings containing JWT', () {
        const jwt =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
        expect(CaseIdentifyRegex.isAnyCase('token=$jwt'), isTrue);
      });

      test('should accept strings containing UUID', () {
        expect(
          CaseIdentifyRegex.isAnyCase(
            'id: 550e8400-e29b-41d4-a716-446655440000',
          ),
          isTrue,
        );
      });

      test('should accept strings that are suspect to not be user facing', () {
        // Long string without spaces
        expect(CaseIdentifyRegex.isAnyCase('a' * 100), isTrue);

        // Long base64-like string
        expect(
          CaseIdentifyRegex.isAnyCase(
            'YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXowMTIzNDU2Nzg5YWJjZGVmZ2hpams=',
          ),
          isTrue,
        );
      });

      test('should accept strings containing file references', () {
        expect(CaseIdentifyRegex.isAnyCase('player_styles.dart'), isTrue);
        expect(
          CaseIdentifyRegex.isAnyCase('subscriber_entries.freezed.dart'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isAnyCase('subscriber_entries.g.dart'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isAnyCase(
            'package:dsf_ms_proto/proto/dreamstock/dsf_ms_scout/v3/player_level.pb.dart',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isAnyCase(
            'package:dsf_ms_proto/proto/dreamstock/dsf_ms_scout/v3/selection.pb.dart',
          ),
          isTrue,
        );
      });
    });

    group('isFirebaseAppIdLike', () {
      test('should identify valid Firebase App IDs', () {
        // Web platform Firebase App IDs
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:515286619892:web:2630b144e9f5abe26630a1',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:624574984834:web:33d55a9ff038e16d72ba9b',
          ),
          isTrue,
        );
        
        // iOS platform Firebase App IDs
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:515286619892:ios:7713b8c61ad139b56630a1',
          ),
          isTrue,
        );
        
        // Android platform Firebase App IDs
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:515286619892:android:c9ebb42700dfc53f6630a1',
          ),
          isTrue,
        );
        
        // Other valid patterns with alphanumeric and colons
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike('ABC123:def456:GHI:789jkl'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike('a:b:c:d:e:f'),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike('123:456:789'),
          isTrue,
        );
      });

      test('should reject invalid Firebase App ID patterns', () {
        // Empty string
        expect(CaseIdentifyRegex.isFirebaseAppIdLike(''), isFalse);
        
        // Contains spaces
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:515286619892:web:2630b144e9f5abe2 6630a1',
          ),
          isFalse,
        );
        
        // Contains special characters other than colon
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:515286619892:web:2630b144e9f5abe2-6630a1',
          ),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:515286619892:web:2630b144e9f5abe2_6630a1',
          ),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:515286619892:web:2630b144e9f5abe2.6630a1',
          ),
          isFalse,
        );
        
        // Contains slash
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:515286619892:web/2630b144e9f5abe26630a1',
          ),
          isFalse,
        );
        
        // Contains brackets or parentheses
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:515286619892:[web]:2630b144e9f5abe26630a1',
          ),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '1:515286619892:(web):2630b144e9f5abe26630a1',
          ),
          isFalse,
        );
        
        // Contains quotes
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            '"1:515286619892:web:2630b144e9f5abe26630a1"',
          ),
          isFalse,
        );
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            "'1:515286619892:web:2630b144e9f5abe26630a1'",
          ),
          isFalse,
        );
        
        // Contains equals sign
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            'appId=1:515286619892:web:2630b144e9f5abe26630a1',
          ),
          isFalse,
        );
        
        // URL-like patterns (should fail due to slashes)
        expect(
          CaseIdentifyRegex.isFirebaseAppIdLike(
            'https://firebase.com/1:515286619892:web:2630b144e9f5abe26630a1',
          ),
          isFalse,
        );
      });

      test('should be included in isAnyCase', () {
        // Valid Firebase App IDs should be detected by isAnyCase
        expect(
          CaseIdentifyRegex.isAnyCase(
            '1:515286619892:web:2630b144e9f5abe26630a1',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isAnyCase(
            '1:624574984834:web:33d55a9ff038e16d72ba9b',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isAnyCase(
            '1:515286619892:ios:7713b8c61ad139b56630a1',
          ),
          isTrue,
        );
        expect(
          CaseIdentifyRegex.isAnyCase(
            '1:515286619892:android:c9ebb42700dfc53f6630a1',
          ),
          isTrue,
        );
      });
    });
  });
}
