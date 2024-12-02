import 'package:chat_app/data/user_data.dart';
import 'package:chat_app/repo/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserController {
  final bool? isError;
  final String? message;
  final UserData? userData;
  final bool? isLoading;

  UserController({this.isError, this.isLoading, this.message, this.userData});

  UserController copyWith({
    bool? isError,
    String? message,
    UserData? userData,
    bool? isLoading,
  }) {
    return UserController(
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        userData: userData ?? userData);
  }
}

class UserProvider extends StateNotifier<UserController> {
  final Ref ref;
  UserProvider(this.ref)
      : super(UserController(
            isError: false, isLoading: false, message: '', userData: null));

  Future signUpWithEmailAndPassword(
      //register
      {required String email,
      required String password,
      required String name}) async {
    try {
      state = state.copyWith(isLoading: true);
      final UserData data = await ref
          .read(authRepoProvider)
          .signUpWithEmailAndPassword(
              email: email, password: password, name: name);
      state = state.copyWith(
          userData: data,
          isError: false,
          isLoading: false,
          message: 'user created succefully');
    } catch (e) {
      state = state.copyWith(
          userData: null,
          isError: true,
          isLoading: false,
          message: 'failed to create user');
    }
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      state = state.copyWith(isLoading: true);
      final userData = await ref
          .read(authRepoProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      state = state.copyWith(
          userData: userData,
          isError: false,
          isLoading: false,
          message: 'user login successfully');
    } catch (e) {
      state = state.copyWith(
          userData: null,
          isError: true,
          isLoading: false,
          message: 'failed to login');
    }
  }

  Future logout() async {
    await ref.read(authRepoProvider).signOut();
    state = state.copyWith(
        userData: null,
        isError: false,
        isLoading: false,
        message: 'user logout successfully');
  }
}

final userProvider = StateNotifierProvider<UserProvider, UserController>((ref) {
  return UserProvider(ref);
});
