import 'package:chat_app/extension/build_context_extension.dart';
import 'package:chat_app/repo/auth_repo.dart';
import 'package:chat_app/ui/screen/all_user_screen.dart';
import 'package:chat_app/ui/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      checkUser();
    });
  }

  void checkUser() {
    bool isuserLoggedIn = ref.read(authRepoProvider).isUserLoggedIn();
    if (isuserLoggedIn) {
      context.navigateToscreen(const AllUserScreen(), isreplace: true);
    } else {
      context.navigateToscreen(LoginScreen(), isreplace: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userNotifier = ref.watch(userProvider);
    return Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.red,
      )
          //ElevatedButton(
          //     onPressed: () async {
          //       await ref
          //           .read(userProvider.notifier)
          //           .signUpWithEmailAndPassword(
          //               email: 'mauli@b.com',
          //               password: '09834095',
          //               name: 'pratik')
          //           .then((value) {
          //         if (!userNotifier.isError!) {
          //           context.navigateToscreen(AllUserScreen(), isreplace: true);
          //         } else {
          //           log(userNotifier.message!.toString());
          //         }
          //       });
          //     },
          //     child: userNotifier.isLoading!
          //         ? const CircularProgressIndicator()
          //         : const Text('signup')),
          ),
    );
  }
}
