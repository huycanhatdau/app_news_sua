import 'package:auth_fire/import.dart';

class MessageController extends GetxController {
  final FirebaseFirestore fireStore;

  MessageController({required this.fireStore});

  CollectionReference get messages => fireStore.collection('message');

  Future<void> addMessage() async {
    await messages.add(<String, dynamic>{
      'message': 'Xin chào',
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteMessage(String docId) async {
    await messages.doc(docId).delete();
  }
}