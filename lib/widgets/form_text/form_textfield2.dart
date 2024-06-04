import 'package:auth_fire/import.dart';

class FormTextFieldAuth extends StatefulWidget {
  const FormTextFieldAuth({
    super.key,
    required this.textEditingController,
    this.hintText,
    this.isError = false,
    this.errorText,
    this.isEmail = false,
    required this.labelText,
    this.onChanged,
    this.keyInput,
    this.isShow = false,
    this.suffixIcon,
  });

  final TextEditingController textEditingController;
  final String? hintText;
  final bool isError;
  final String? errorText;
  final bool isEmail;
  final String labelText;
  final Function(String)? onChanged;
  final Key? keyInput;
  final bool isShow;
  final Widget? suffixIcon;

  @override
  State<FormTextFieldAuth> createState() => _FormTextFieldAuthState();
}

class _FormTextFieldAuthState extends State<FormTextFieldAuth> {
  /// Nếu dùng errorMessage thì cần set didUpdated còn không dùng message trả về
  /// trực tiếp
  // late String errorMessage = '';
  //
  // @override
  // void initState() {
  //   errorMessage = widget.errorText ?? '';
  //   super.initState();
  // }
  //
  // @override
  // void didUpdateWidget(covariant FormTextField2 oldWidget) {
  //   if(widget.errorText != oldWidget.errorText) {
  //     setState(() {
  //       errorMessage = widget.errorText ?? '';
  //     });
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(30),
                topLeft: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: !empty(widget.errorText)
                      ? Colors.red
                      : const Color(0x71949494),
                  offset: Offset(
                    0.0,
                    !empty(widget.errorText) ? 0.0 : 2.0,
                  ),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                ), //BoxShadow
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.labelText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextField(
                  obscureText: widget.isShow,
                  controller: widget.textEditingController,
                  key: widget.keyInput,
                  decoration: InputDecoration(
                    fillColor: Colors.white54,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    contentPadding: const EdgeInsets.only(right: 0, left: 0),
                    focusColor: Colors.white60,
                    // errorText: !empty(widget.errorText) ? widget.errorText : null,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    suffixIcon: widget.suffixIcon,
                  ),
                  onChanged: widget.onChanged,
                ),
              ],
            ),
          ),
          h(4),
          if (widget.errorText != null && widget.errorText!.isNotEmpty)
            Text(
              widget.errorText!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            )
        ],
      ),
    );
  }
}
