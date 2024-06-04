import 'package:auth_fire/import.dart';



class AuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await firebaseInstance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final docRef = fireStoreInit.collection('accounts').doc(userCredential.user!.uid);

      // Check if the document exists before starting the transaction
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        await fireStoreInit.runTransaction((transaction) async {
          transaction.set(docRef, {
            'uid': userCredential.user!.uid,
            'email': email,
          });
        });
      }

      if (!empty(userCredential.user!.uid)) {
        factories['accountId'] = userCredential.user!.uid;
        await storageLocal.saveValue('loginBox', 'accountId', factories['accountId']);
        Get.offAllNamed('/initStart');
      }

      return userCredential.user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'wrong-password':
            throw Exception("Mật khẩu không chính xác.");
          case 'invalid-credential':
            throw Exception("Định dạng mật khẩu không chính xác.");
          case 'too-many-requests':
            throw Exception("Vui lòng chờ.");
          default:
            throw Exception("Đăng nhập thất bại. Vui lòng thử lại sau.");
        }
      }
      throw Exception("Đăng nhập thất bại. Vui lòng thử lại sau. $e");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Người dùng đã hủy đăng nhập');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (empty(googleAuth)) {
        throw Exception('Failed to get Google authentication');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await firebaseInstance.signInWithCredential(credential);
      final docRef = fireStoreInit.collection('accounts').doc(userCredential.user!.uid);

      // Check if the document exists before starting the transaction
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        await fireStoreInit.runTransaction((transaction) async {
          transaction.set(docRef, {
            'uid': googleUser.id,
            'email': googleUser.email,
          });
        });
      }

      if (!empty(googleUser.id)) {
        factories['accountId'] = googleUser.id;
        await storageLocal.saveValue('loginBox', 'accountId', factories['accountId']);
        Get.offAllNamed('/initStart');
      }

      print('accountIdaccountId at finr ${factories['accountId']}');

      return await firebaseInstance.signInWithCredential(credential);
    } catch (e) {
      throw ('Error during Google sign-in: $e');
    }
  }

  Future<void> signOut() async {
    final User? firebaseUser = firebaseInstance.currentUser;
    if (firebaseUser != null) {
      await firebaseInstance.signOut();
    }
    await googleSignIn.signOut();
    await _secureStorage.deleteAll();

    await storageLocal.deleteValue('loginBox', 'accountId');

    if (Hive.isBoxOpen('loginBox')) {
      await storageLocal.closeBox('loginBox');
    }

    Get.offAllNamed('/initStart');
  }

  Future<User?> createUser(String email, String password, String phone, String address) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if(!empty(userCredential.user!.uid)) {
        await fireStoreInit.collection('accounts').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'phone': phone,
          'address': address
        });
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw('The account already exists for that email.');
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}