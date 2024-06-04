import 'package:auth_fire/import.dart';

class AccountHomeController extends GetxController {

  final currentUser = firebaseInstance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Map? currentInformation;
  Future<void> fetchData() async {
    final docSnapshot = await fireStoreInit.collection('accounts').doc(firebaseInstance.currentUser?.uid).get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      currentInformation = data;
    }
    update();
  }

  Future<void> signOut() async {
    await AuthService().signOut();
  }
}
