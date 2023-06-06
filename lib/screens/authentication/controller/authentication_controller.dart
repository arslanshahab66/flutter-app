import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home/screen/home.dart';
import '../screens/login.dart';

class AuthtenticationController {
  static signup(BuildContext context, userEmail, password) async {
    print("SinnUp........");
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: "$userEmail", password: "$password");
      User? user = userCredential.user;

      user!.updateDisplayName("test");
      print("update username = ${user.displayName}");
      // var email  = user!.email;
      storedatainFirestore(userEmail, password);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignInScreen()));
      return user;
    } on FirebaseAuthException catch (e) {
      print("Firebase exception:  ${e.code}");
      if (e.code == "invalid-email") {
        print("kindly enter valid Email address");
      } else if (e.code == "weak-password") {
        print("kindly your password should be greater then 6 char");
      } else if (e.code == "email-already-in-use") {
        print("This email address already exist");
      }
    } catch (e) {
      print("e: $e");
    }
  }

  static signIn(
      {required context, required UserEmail, required password}) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: "$UserEmail", password: "$password");

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (ex) {
      print("Firebase Login Exception: $ex");
      if (ex.code == "user-not-found") {
        print("user not found try again ");
      }
    } catch (e) {
      print("e $e");
    }
  }

  static storedatainFirestore(email, password) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var uid = firebaseAuth.currentUser!.uid;
      await firebaseFirestore.collection("employee").doc().set({
        "name": "$email",
        "password": "$password",
      });

      print(
          "_____________________________ data Save Success!_____________________");
    } catch (e) {
      print("Save data e: $e");
    }
  }

  static additem() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    await firebaseFirestore
        .collection("item")
        .doc(firebaseAuth.currentUser!.uid)
        .set({
      "item Name": "Grap",
      "item price": "200",
      "stock": 5,
    });

    print("item Added_________________________________");
  }

  static updateitem() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    await firebaseFirestore
        .collection("item")
        .doc(firebaseAuth.currentUser!.uid)
        .update({
      "item Name": "Grapes",
    });

    print("item Updated_________________________________");
  }

  static getitem() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    QueryDocumentSnapshot data = await firebaseFirestore
        .collection("item")
        .doc(firebaseAuth.currentUser!.uid)
        .get() as QueryDocumentSnapshot;
    print(data.data());
    print("item Added_________________________________");
  }
}
