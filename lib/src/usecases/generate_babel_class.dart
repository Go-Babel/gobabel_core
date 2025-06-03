import 'package:gobabel_core/gobabel_core.dart';
import 'package:gobabel_core/src/core/generated_files_reference/babel_text.dart';

class GenerateBabelClassUsecase {
  String call({
    required BigInt projectShaIdentifier,
    required Set<BabelFunctionDeclaration> declarationFunctions,
  }) {
    final StringBuffer fileContent = StringBuffer(babelText);
    for (final BabelFunctionDeclaration d in declarationFunctions) {
      fileContent.write('$d\n');
    }

    fileContent.write('\n}');

    return fileContent
        .toString()
        .replaceAll(
          r"const String _gobabelRoute = 'http://localhost:8080';",
          "const String _gobabelRoute = 'http://gobabel.dev';",
        )
        .replaceAll(
          r"const String _projectIdentifier = '';",
          "const String _projectIdentifier = '$projectShaIdentifier';",
        );
  }
}
