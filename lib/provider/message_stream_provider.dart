import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/repo/message_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageStreamProvider =
    StreamProvider.autoDispose<Iterable<MessageData>>((ref) {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  return ref.watch(MessageRepoProvider).getAllMessages();
});
