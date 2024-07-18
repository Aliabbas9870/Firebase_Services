import 'dart:io';
import 'package:appdata/login.dart';
import 'package:appdata/main.dart';
import 'package:appdata/phoneauth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appdata/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  File? pickedImage;
  void signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      UiHelper.CustomAlertBox(context, "Please Fill all fields");
    } else {
      try {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        if (credential.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(title: "Email Sign Up"),
            ),
          );
        }
      } on FirebaseAuthException catch (ex) {
        UiHelper.CustomAlertBox(context, ex.code.toString());
      } catch (ex) {
        UiHelper.CustomAlertBox(context, ex.toString());
      }
    }
  }
  void showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pick Image From"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.image),
                title: Text("Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up With Email/Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showImageSourceDialog();
              },
              child: pickedImage != null
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(pickedImage!),
                    )
                  : CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person),
                    ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  suffixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                signUp(emailController.text.trim(), passController.text.trim());
              },
              child: Text("Sign Up"),
            ),
            SizedBox(height: 12),
            UiHelper.CustomButton(
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneAuth()),
                );
              },
              "Phone Auth",
            ),
            SizedBox(height: 12),
            UiHelper.CustomButton(
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              "Sign In",
            ),
          ],
        ),
      ),
    );
  }
  void pickImage(ImageSource imageSource) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      if (pickedFile != null) {
        final tempImage = File(pickedFile.path);
        setState(() {
          pickedImage = tempImage;
        });
      }
    } catch (ex) {
      UiHelper.CustomAlertBox(context, ex.toString());
    }
  }
}
