import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/data/user_data.dart';
import 'package:chat_app/extension/build_context_extension.dart';
import 'package:chat_app/provider/message_stream_provider.dart';
import 'package:chat_app/repo/message_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  ChatScreen({super.key, required this.userData});

  final UserData userData;
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageStream = ref.watch(messageStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.person),
            ),
            Text(userData.name!),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 30,
            child: messageStream.when(
                data: (messagelist) {
                  return ListView.builder(
                      reverse: true,
                      itemCount: messagelist.length,
                      itemBuilder: (context, index) {
                        // ignore: non_constant_identifier_names
                        final MessageData = messagelist.elementAt(index);
                        return ListTile(
                          title: Text(MessageData.message!),
                          subtitle: Text(DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(MessageData.timestamp!))
                              .toString()),
                        );
                      });
                },
                error: (err, skt) {
                  return Center(
                    child: Text(err.toString()),
                  );
                },
                loading: () => const Column(
                      children: [
                        Center(child: LinearProgressIndicator()),
                      ],
                    )),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 100,
              alignment: Alignment.topCenter,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: context.getwidth(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'type a message ',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        final MessageData messageData = MessageData(
                            message: _messageController.text.trim(),
                            reciverid: userData.uid,
                            senderid: FirebaseAuth.instance.currentUser!.uid,
                            timestamp: DateTime.now()
                                .microsecondsSinceEpoch
                                .toString(),
                            type: 'text');

                        await ref
                            .read(MessageRepoProvider)
                            .sendMessage(messagedata: messageData)
                            .then((value) {
                          _messageController.clear();
                        });
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
