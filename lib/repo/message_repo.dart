import 'package:chat_app/data/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageRepo {
  final Ref ref;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  MessageRepo({required this.ref});

  Future sendMessage({required MessageData messagedata}) async {
    try {
      await _firestore.collection('messages').add(messagedata.toJson());
    } catch (e) {
      Future.error(e);
    }
  }

  Stream<Iterable<MessageData>> getAllMessages() async* {
    yield* _firestore
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (data) => data.docs.map(
            (message) => MessageData.fromJson(
              message.data(),
            ),
          ),
        );
  }
}

// ignore: non_constant_identifier_names
final MessageRepoProvider = Provider((ref) => MessageRepo(ref: ref));
