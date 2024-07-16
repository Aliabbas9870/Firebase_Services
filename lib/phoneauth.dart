import 'package:appdata/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted:
                        (PhoneAuthCredential credential) async {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verifyid, int? resenttoken) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTP(
                                    verifyid: verifyid,
                                  )));
                    },
                    codeAutoRetrievalTimeout: (String verifyid) {},
                    phoneNumber: phoneController.text.toString());
              },
              child: Text("Verify Phone"))
        ],
      ),
    );
  }
}
