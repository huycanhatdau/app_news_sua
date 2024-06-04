import 'package:auth_fire/import.dart';
import 'package:auth_fire/pages/account/information/controller.dart';

class AccountInformationPage extends StatelessWidget {
  const AccountInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AccountInformationController>(
          init: AccountInformationController(),
          builder: (controller) {
            return const Text('a');
          }
        ),
      ),
    );
  }
}
