import 'package:recase/recase.dart';
import 'package:gobabel_core/gobabel_core.dart';

class InferDeclarationFunctionByArbValueUsecase {
  final RegExp regex = RegExp(r'{(?<dynamicField>[\w|\s]+)}', multiLine: true);

  BabelFunctionDeclaration call({
    required L10nKey key,
    required L10nValue value,
  }) {
    String funcName = key;
    final List<String> dynamicFields = [];

    final Iterable<RegExpMatch> matches = regex.allMatches(value);
    for (final RegExpMatch match in matches) {
      final String dynamicField = match.namedGroup('dynamicField')!;
      dynamicFields.add(dynamicField);
    }

    return '''${value.formatToComment}
  static String $funcName(${dynamicFields.map((e) => 'Object? $e').join(', ')}) {
    return i._getByKey('$key')${dynamicFields.map((e) => '.replaceAll(\'{$e}\', $e.toString())').join()};
  }''';
  }
}

extension StringExtensions on String {
  String get toCamelCase {
    return
    // Replace all not digits (only a-z, and digits) by space
    replaceAll(RegExp(r'\W'), ' ').replaceAll(RegExp(r'\s{1,}'), ' ').camelCase;
  }

  String get formatToComment {
    return '  /// ${replaceAll(RegExp('\n'), '<p>\n/// ')}';
  }
}
