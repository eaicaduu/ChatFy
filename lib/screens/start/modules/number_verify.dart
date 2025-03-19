import 'package:chat/screens/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../database/database.dart';
import '../confirm.dart';

void verifyPhoneNumber(String phoneNumber, BuildContext context, Function onComplete) {
  String cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
  String formattedPhoneNumber = "+55$cleanedPhoneNumber";

  FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: formattedPhoneNumber,
    timeout: const Duration(seconds: 60),
    verificationCompleted: (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);
      onComplete();
    },
    verificationFailed: (FirebaseAuthException e) {
      onComplete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: ${e.message}")),
      );
    },
    codeSent: (String verificationId, int? resendToken) {
      onComplete();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            phoneNumber: formattedPhoneNumber,
            verificationId: verificationId,
          ),
        ),
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      onComplete();
    },
  );
}

void verifyCode(String code, String verificationId, BuildContext context, String phoneNumber, Function(bool) setError,) async {
    await saveSession(phoneNumber, context);
}

Future<void> saveSession(String phoneNumber, BuildContext context) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  String? existingSession = await databaseHelper.getSession();

  if (existingSession != null) {
    await db.collection('sessions').doc(existingSession).delete();
    await databaseHelper.clearSession();
    await auth.signOut();
  }

  DocumentSnapshot sessionSnapshot = await db.collection('sessions').doc(phoneNumber).get();

  if (sessionSnapshot.exists) {
    await db.collection('sessions').doc(phoneNumber).set({
      'phoneNumber': phoneNumber,
      'timestamp': FieldValue.serverTimestamp(),
    });

    await databaseHelper.saveSession(phoneNumber);
  } else {
    await databaseHelper.saveSession(phoneNumber);
  }

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MenuScreen()),
  );
}