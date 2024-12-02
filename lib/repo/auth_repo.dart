import 'dart:developer';

import 'package:chat_app/data/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserData> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      // ignore: non_constant_identifier_names
      final UserCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final UserData userData = UserData(
          name: name,
          uid: UserCredential.user!.uid,
          email: email,
          profilepic: '',
          bio: 'new to chat app ',
          createdOn: DateTime.now().toString());
      await addUserdataToDatabase(userData);
      return userData;
    } catch (e) {
      log(e.toString());
      return Future.error(e);
    }
  }

  Future<dynamic> addUserdataToDatabase(UserData userData) async {
    try {
      _firestore
          .collection('users')
          .doc(userData.uid)
          .set(userData.toJson())
          .catchError((e) {
        log(e.toString());
        return Future.error(e);
      }).then((value) {
        log('user data added to database');
      });
    } catch (e) {
      log(e.toString());
      return Future.error(e);
    }
  }

  Future<UserData> getCurrentUser(String uid) async {
    try {
      final user = await _firestore.collection('users').doc(uid).get();
      return UserData.fromJson(user.data()!);
    } catch (e) {
      log(e.toString());
      throw Future.error(e);
    }
  }

  Future<UserData> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userDataResponse = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final data = userDataResponse.user;
      final userData = await getCurrentUser(data!.uid);
      return userData;
    } catch (e) {
      log(e.toString());
      return Future.error(e);
    }
  }

  bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}

final authRepoProvider = Provider((ref) => AuthRepo());
