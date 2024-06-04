import 'package:auth_fire/import.dart';

class AccountRegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool passwordVisible = false;

  String? errorMessage;
  String? errorMessagePass;

  Future<void> submit() async {
    final email = emailController.text;
    final password = passwordController.text;
    final phone = phoneController.text;
    final address = addressController.text;

    try {
      if(empty(email)) {
        validateEmail(email);
      } else if(empty(password)) {
        validatePassword(password);
      } else {
        await AuthService().createUser(email, password, phone, address);
      }
    } catch (e) {
      throw('Có lỗi xảy ra $e');
    }
  }

  void validateEmail(String text) {
    if (empty(text)) {
      errorMessage = 'Vui lòng nhập email';
    } else if (!empty(emailController.text) && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(text)) {
      errorMessage = 'Địa chỉ email không chính xác';
    } else {
      errorMessage = '';
    }
    update();
  }

  void validatePassword(String passowrd) {
    if (empty(passowrd)) {
      errorMessagePass = 'Vui lòng nhập mật khẩu';
    } else if (!empty(emailController.text) && !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$").hasMatch(passowrd)) {
      errorMessagePass = 'Mật khẩu phải chứa một chữ số từ 1 đến 9, một chữ cái viết thường, một chữ cái viết hoa, một ký tự đặc biệt, không có khoảng trắng và phải dài 8-16 ký tự.';
    } else {
      errorMessagePass = '';
    }
    update();
  }

  Future<void> singInWithGoogle() async {
    await AuthService().signInWithGoogle();
  }
}