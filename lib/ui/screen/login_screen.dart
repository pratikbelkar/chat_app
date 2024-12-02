import 'dart:developer';
import 'dart:ffi';

import 'package:chat_app/extension/build_context_extension.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/repo/auth_repo.dart';
import 'package:chat_app/ui/screen/all_user_screen.dart';
import 'package:chat_app/ui/screen/common_button.dart';
import 'package:chat_app/ui/screen/common_text_form_field.dart';
import 'package:chat_app/ui/screen/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.watch(userProvider);
    // final TextEditingController EmailController;
    // final TextEditingController _passwordcontroller;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonTextFormField(
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return 'enter correct email';
                }
              },
              Hinttext: 'Email',
              isPassword: false,
              prefixicon: Icons.mail,
              Controller: _emailcontroller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonTextFormField(
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return 'enter password';
                }
              },
              Hinttext: 'password',
              isPassword: true,
              prefixicon: Icons.lock,
              Controller: _passwordController,
            ),
          ),
          TextButton(
              onPressed: () {
                context.navigateToscreen(RegistrationScreen());
              },
              child: const Text(
                'New User?  Register here',
                style: TextStyle(color: Colors.black),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonButton(
              onPressed: () {
                ref.read(userProvider.notifier).signInWithEmailAndPassword(
                    email: _emailcontroller.text,
                    password: _passwordController.text);
                if (!loginNotifier.isError! && loginNotifier.userData != null) {
                  context.navigateToscreen(const AllUserScreen(),
                      isreplace: true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.white,
                      duration: Duration(seconds: 3),
                      showCloseIcon: false,
                      content: Center(
                        child: Column(
                          children: [
                            Text(
                              'User not found?',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('please Register your account',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  );
                  log('failed to login');
                }
              },
              title: 'Login',
              isLoading: false,
            ),
          )
        ],
      ),
    );
  }
}
