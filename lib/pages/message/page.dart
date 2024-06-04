import 'package:auth_fire/import.dart';
import 'package:auth_fire/pages/message/controller.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key, required this.fireStore});

  final FirebaseFirestore fireStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<MessageController>(
            init: MessageController(fireStore: fireStore),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h(30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonBase(
                      onTap: () {
                        controller.addMessage();
                      },
                      title: 'Thêm mới message',
                    ),
                  ),
                  h(20),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: fireStore.collection('message').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (empty(snapshot.hasData)) {
                          return const Center(child: Text('Loading...'));
                        }
                        final int messageCount = snapshot.data!.docs.length;

                        if(empty(messageCount)) {
                          return const Center(child: Text('Không có message nào'));
                        } else {
                          return ListView.builder(
                            itemCount: messageCount,
                            itemBuilder: (context, index) {
                              DocumentSnapshot document = snapshot.data!.docs[index];

                              final dynamic message = document['message'];
                              return ListTile(
                                title: Text(
                                  message != null ? message.toString() : '<No message retrieved>',
                                ),
                                subtitle: Text('Message ${index + 1} of $message'),
                                trailing: InkWell(
                                  onTap: () {
                                    controller.deleteMessage(document.id);
                                  },
                                  child: const Text('Xóa Item'),
                                ),
                              );
                            },
                          );
                        }
                        //
                        //
                        // print('messageCount $messageCount');
                        // return ListView.builder(
                        //   itemCount: messageCount,
                        //   itemBuilder: (context, index) {
                        //     DocumentSnapshot document = snapshot.data!.docs[index];
                        //
                        //     final dynamic message = document['message'];
                        //     return ListTile(
                        //       title: Text(
                        //         message != null ? message.toString() : '<No message retrieved>',
                        //       ),
                        //       subtitle: Text('Message ${index + 1} of $message'),
                        //       trailing: InkWell(
                        //         onTap: () {
                        //           controller.deleteMessage(document.id);
                        //         },
                        //         child: const Text('Xóa Item'),
                        //       ),
                        //     );
                        //   },
                        // );
                      },
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
