import 'package:formz/formz.dart';

// Define los errores de validación del input
enum DescriptionError { empty }

// Extiende FormzInput y proporciona el tipo de entrada y el tipo de error.
class Description extends FormzInput<String, DescriptionError> {
  // Llama a super.pure para representar un campo de formulario no modificado.
  const Description.pure() : super.pure('');

  // Llama a super.dirty para representar un campo de formulario modificado.
  const Description.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DescriptionError.empty) return 'El campo es requerido';

    return null;
  }

  // Sobrescribe el validador para manejar la validación del valor ingresado.
  @override
  DescriptionError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DescriptionError.empty;

    return null;
  }
}
