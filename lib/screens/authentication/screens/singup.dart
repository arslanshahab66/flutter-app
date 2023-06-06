import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/authentication_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Screen"),
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
                var user = await AuthtenticationController.signup(
                  context,
                  emailController.text,
                  passwordController.text,
                );

                print("user: $user");
              },
              child: const Text("SignUp")),
        ],
      ),
    );
  }
}
