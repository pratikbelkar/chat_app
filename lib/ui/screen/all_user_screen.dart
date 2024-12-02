import 'package:chat_app/extension/build_context_extension.dart';
import 'package:chat_app/provider/all_users_final_provider.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/screen/chat_screen.dart';

import 'package:chat_app/ui/screen/login_screen.dart';
import 'package:chat_app/ui/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllUserScreen extends ConsumerStatefulWidget {
  const AllUserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends ConsumerState<AllUserScreen> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue allUsers = ref.watch(allUsersFinalProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            'AllUsers Screen',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        actions: [
          IconButton(
              onPressed: () async {
                await ref.read(userProvider.notifier).logout().then((value) {
                  context.navigateToscreen(const SplashScreen(),
                      isreplace: true);
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: allUsers.when(
          data: (userList) {
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      thickness: 2,
                    ),
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(
                        userList[index].name,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      subtitle: Text(userList[index].email),
                      onTap: () {
                        context.navigateToscreen(ChatScreen(
                          userData: userList[index],
                        ));
                      });
                });
          },
          error: (skt, err) {
            print(err.toString());
          },
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
