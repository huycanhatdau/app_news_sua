import 'package:auth_fire/import.dart';
import 'package:auth_fire/pages/account/login/controller.dart';
import 'package:auth_fire/widgets/form_text/form_textfield2.dart';

class AccountLoginPage extends StatelessWidget {
  const AccountLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formLogin = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              h(80),
              const Center(
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              h(20),
              GetBuilder<LoginController>(
                init: LoginController(),
                builder: (controller) {
                  return Form(
                    key: formLogin,
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
                        Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed('/');
                            },
                            child: const Text(
                              'Quên mật khẩu ?',
                              style: TextStyle(
                                color: Color(0xb8000000),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        h(10),
                        ButtonBase(
                          key: const Key('submit_button'),
                          onTap: () {
                            if (formLogin.currentState!.validate()) {
                              controller.submit();
                            }
                          },
                          title: 'Đăng nhập',
                          isFull: true,
                        ),
                      ],
                    ),
                  );
                },
              ),
              h(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 100, decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey))),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text('hoặc'),
                  ),
                  Container(width: 100, decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey))),
                ],
              ),
              h(30),
              GetBuilder<LoginController>(
                init: LoginController(),
                builder: (controller) {
                  return InkWell(
                    onTap: () {
                      controller.singInWithGoogle();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: const Color(0x71949494)),
                          boxShadow: const [
                            BoxShadow(color: Color(0x71949494), offset: Offset(0.0, 2.0), blurRadius: 4.0, spreadRadius: 0.0), //BoxShadow
                            BoxShadow(color: Colors.white, offset: Offset(0.0, 0.0), blurRadius: 0.0, spreadRadius: 0.0),
                          ]
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/google.png', width: 20, height: 20),
                          w(20),
                          const Text('Đăng nhập với Google', style: TextStyle(color: Color(0xb8000000), fontWeight: FontWeight.w700),)
                        ],
                      ),
                    ),
                  );
                },
              ),
              h(30),
              Row(
                children: [
                  const Text('Bạn chưa có tài khoản?'),
                  w(10),
                  Container(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/register');
                      },
                      child: const Text(
                        'Đăng ký',
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
    );
  }
}
