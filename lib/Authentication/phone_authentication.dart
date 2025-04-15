import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rental_estate_app/view/main_screen.dart';

import '../view/verification_screen.dart';

Future<void> sendVerificationCode(String phoneNumber, BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? verificationId;

  await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    timeout: const Duration(seconds: 60),
    verificationCompleted: (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AppMainScreen()),
      );
    },
    verificationFailed: (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The provided phone number is not valid.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    },
    codeSent: (String verificationId, int? resendToken) async {
      // Сохраняем verificationId для последующей проверки кода
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationScreen(verificationId: verificationId),
        ),
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      // Обработка таймаута автоматического получения кода
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Code auto-retrieval timed out.')),
      );
    },
  );
}