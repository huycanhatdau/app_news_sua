import 'package:auth_fire/pages/home/controller.dart';
import 'package:auth_fire/import.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = firebaseInstance.currentUser;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          h(30),
                          Center(child: Text('Tài khoản: $currentUser'),),
                        ],
                      ),
                    ),
                  ),
                ),
            );
          },
        ),
      ),
    );
  }
}

