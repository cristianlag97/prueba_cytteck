part of 'widgets.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final String? errorText;
  final int maxLines;
  final ValueChanged<String> onChanged;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.initialValue,
    this.errorText,
    this.maxLines = 1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: maxLines > 1 ? 'Escribe tu nota aquí...' : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CyttekColor.redColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CyttekColor.redColor),
        ),
        errorText: errorText,
        alignLabelWithHint: maxLines > 1,
        contentPadding: const EdgeInsets.all(size16),
      ),
    );
  }
}
