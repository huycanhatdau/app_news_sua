import 'package:auth_fire/import.dart';
import 'package:auth_fire/pages/account/home/controller.dart';
import 'package:auth_fire/pages/account/home/widgets/menu.dart';

class AccountHomePage extends StatelessWidget {
  const AccountHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountHomeController>(
      init: AccountHomeController(),
      builder: (controller) {
        print('currentInformation ${controller.currentInformation}');
          return Scaffold(
          appBar: factories['header'](
            context,
            label: !empty(controller.currentUser?.uid) ? 'Thông tin cá nhân' : 'Đăng nhập',
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h(30),
              if (!empty(controller.currentUser?.uid))
                AccountHomeMenu(controller.currentInformation ?? {})
              else
                ButtonBase(onTap: () {
                  Get.toNamed('/login');
                }, title: 'Đăng nhập ngay')
            ],
          ),
        );
      }
    );
  }
}
