import 'package:appdata/forgetpass.dart';
import 'package:appdata/main.dart';
import 'package:appdata/phoneauth.dart';
import 'package:appdata/signup.dart';
import 'package:appdata/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passControler = TextEditingController();
  Sign(String email, String password) async {
    if (email == '' && password == "") {
      UiHelper.CustomAlertBox(context, "Please Fill all field");
    } else {
      UserCredential? credential;
      try {
        credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (ex) {
        UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login With Email/Pass"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
              maxRadius: 40,
              child: Icon(
                Icons.person,
                size: 45,
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailControler,
                decoration: InputDecoration(
                    hintText: "Enter Email",
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passControler,
                decoration: InputDecoration(
                    hintText: "Enter Password",
                    suffixIcon: Icon(Icons.password),
                    border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Sign(emailControler.text.toString(),
                      passControler.text.toString());
                },
                child: Text("Sign in")),
            SizedBox(
              height: 12,
            ),
            UiHelper.CustomButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PhoneAuth()));
            }, "Phone Auth"),
            SizedBox(
              height: 12,
            ),
            UiHelper.CustomButton(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            }, "Sign Up"),
            SizedBox(
              height: 16,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Forgetpass()));
                },
                child: Text("Forget pass")),
          ]),
        ));
  }
}
