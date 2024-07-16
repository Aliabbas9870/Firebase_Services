import 'package:appdata/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTP extends StatefulWidget {
  String verifyid;
  OTP({super.key, required this.verifyid});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController otpControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: otpControl,
              keyboardType: TextInputType.text,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential =
                      await PhoneAuthProvider.credential(
                          verificationId: widget.verifyid,
                          smsCode: otpControl.text.toString());
                  FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((onValue) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(title: "OTP Done")));
                  });
                } catch (e) {
                  print(e);
                }
              },
              child: Text("OTP"))
        ],
      ),
    );
  }
}
