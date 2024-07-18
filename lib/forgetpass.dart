import 'package:appdata/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({super.key});

  @override
  State<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  TextEditingController emailController = TextEditingController();

  foregetpass(String email) async {
    if (email == "") {
      return UiHelper.CustomAlertBox(
          context, "Please Enter Email to Reset password");
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(
              emailController, "Enter Email", Icons.email, false),
          SizedBox(
            height: 15,
          ),
          UiHelper.CustomButton(() {
            foregetpass(emailController.text.toString());
          }, "Reset pass")
        ],
      ),
    );
  }
}
