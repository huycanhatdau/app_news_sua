import 'package:auth_fire/import.dart';
import 'package:auth_fire/pages/account/register/controller.dart';
import 'package:auth_fire/widgets/form_text/form_textfield2.dart';

class AccountRegisterPage extends StatelessWidget {
  const AccountRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formRegister = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                h(20),
                GetBuilder<AccountRegisterController>(
                  init: AccountRegisterController(),
                  builder: (controller) {
                    return Form(
                      key: formRegister,
                      child: Column(
                        children: [
                          FormTextFieldAuth(
                            textEditingController: controller.emailController,
                            labelText: 'Email',
                            hintText: 'Email',
                            errorText: controller.errorMessage,
                            onChanged: (value) {
                              controller.validateEmail(value);
                            },
                          ),
                          FormTextFieldAuth(
                            isShow: !controller.passwordVisible,
                            textEditingController: controller.passwordController,
                            labelText: 'Password',
                            hintText: 'Password',
                            errorText: controller.errorMessagePass,
                            onChanged: (value) {
                              controller.validatePassword(value);
                            },
                          ),
                          FormTextFieldAuth(
                            textEditingController: controller.phoneController,
                            labelText: 'Số điện thoại',
                            hintText: 'Số điện thoại',
                          ),
                          FormTextFieldAuth(
                            textEditingController: controller.addressController,
                            labelText: 'Địa chỉ',
                            hintText: 'Địa chỉ',
                          ),
                          h(10),
                          ButtonBase(
                            key: const Key('submit_button'),
                            onTap: () {
                              if (formRegister.currentState!.validate()) {
                                controller.submit();
                              }
                            },
                            title: 'Đăng ký',
                            isFull: true,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                h(30),
                Row(
                  children: [
                    const Text('Bạn đã có tài khoản?'),
                    w(10),
                    Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Get.offNamed('/login');
                        },
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                            color: Color(0xb8000000),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
