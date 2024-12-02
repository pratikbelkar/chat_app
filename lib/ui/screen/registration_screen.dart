import 'dart:developer';

import 'package:chat_app/data/user_data.dart';
import 'package:chat_app/extension/build_context_extension.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/screen/all_user_screen.dart';
import 'package:chat_app/ui/screen/common_button.dart';
import 'package:chat_app/ui/screen/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationScreen extends ConsumerWidget {
  RegistrationScreen({super.key});

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Registration ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonTextFormField(
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Name cannot empty';
                    }
                  },
                  Hinttext: 'name',
                  prefixicon: Icons.person,
                  Controller: _nameController,
                  isPassword: false),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonTextFormField(
                  validator: (value) {
                    if (value!.isNotEmpty && value.contains('@')) {
                      return null;
                    } else {
                      return 'Enter a valid mail';
                    }
                  },
                  Hinttext: 'Email',
                  prefixicon: Icons.email,
                  Controller: _emailcontroller,
                  isPassword: false),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonTextFormField(
                  validator: (value) {
                    if (value!.length > 7) {
                      return null;
                    } else {
                      return 'Password must contain 8 letters';
                    }
                  },
                  Hinttext: 'password',
                  prefixicon: Icons.lock,
                  Controller: _passwordcontroller,
                  isPassword: true),
            ),
            CommonButton(
              title: 'Register',
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  ref.read(userProvider.notifier).signUpWithEmailAndPassword(
                      email: _emailcontroller.text,
                      password: _passwordcontroller.text,
                      name: _nameController.text);
                  if (context.mounted) {
                    if (!userNotifier.isError! &&
                        userNotifier.userData! != null) {
                      context.navigateToscreen(const AllUserScreen(),
                          isreplace: true);
                    } else {
                      log('message : ${userNotifier.message}');
                    }
                  }
                }
              },
              isLoading: userNotifier.isLoading!,
            ),
          ],
        ),
      ),
    );
  }
}
