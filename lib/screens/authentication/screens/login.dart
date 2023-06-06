import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/authentication_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignIn Screen"),
      ),
      body: Column(
        children: [
          const Text("Email"),
          TextField(
            controller: emailController,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text("Password"),
          TextField(
            controller: passwordController,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                var user = await AuthtenticationController.signIn(
                  context: context,
                  UserEmail: emailController.text,
                  password: passwordController.text,
                );
                AuthtenticationController.storedatainFirestore(
                    emailController, passwordController);
                print("user: $user");
              },
              child: const Text("SignIn")),
        ],
      ),
    );
  }
}
