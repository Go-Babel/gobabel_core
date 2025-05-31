import 'package:gobabel_core/gobabel_core.dart';
import 'package:test/test.dart';

void main() {
  final usecase = InferDeclarationFunctionByArbValueUsecase();
  test('infer declaration function by arb value', () {
    final BabelFunctionDeclaration function = usecase(
      key: 'checkYourEmail',
      value: r'Check your <i><b>\"{arg1}\"<b><i>',
    );
    print(function);
  });
}
