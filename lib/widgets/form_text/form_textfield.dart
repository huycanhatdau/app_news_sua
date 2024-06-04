import 'package:auth_fire/import.dart';

class FormTextField extends StatefulWidget {
  const FormTextField({
    super.key,
    required this.textEditingController,
    this.hintText,
    this.isError = false,
    this.errorText,
    this.isEmail = false,
    required this.labelText,
  });

  final TextEditingController textEditingController;
  final String? hintText;
  final bool isError;
  final String? errorText;
  final bool isEmail;
  final String labelText;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late String errorMessage = '';

  @override
  void initState() {
    errorMessage = widget.errorText ?? '';
    super.initState();
  }

  void _validateText(String text) {
    setState(() {
      if (text.isEmpty) {
        errorMessage = 'This field cannot be empty';
      } else if (widget.isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(text)) {
        errorMessage = 'Invalid email address';
      } else {
        errorMessage = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
              labelText: widget.labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              fillColor: Colors.white54,
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.only(right: 12, left: 12),
              focusColor: Colors.white60,
              errorText: errorMessage.isEmpty ? null : errorMessage,
            ),
            onChanged: (value) {
              _validateText(value);
            },
          ),
          const SizedBox(height: 4),
          if (errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}
