import 'dart:developer';

import 'package:chat_app/data/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allUsersFinalProvider = FutureProvider<List<UserData>>((ref) async {
  // ignore: no_leading_underscores_for_local_identifiers
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    final value = await _firestore.collection('users').get();
    if (value.docs.isNotEmpty) {
      final users =
          value.docs.map((e) => UserData.fromJson((e).data())).toList();
      return users;
    } else {
      log('User not found');
      return Future.error('No users found');
    }
  } catch (e) {
    log('failed to get user');
    return Future.error(e);
  }
});
