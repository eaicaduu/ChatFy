import 'package:chat/screens/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../database/data/database.dart';

String verificationId = '';
int? resendToken;

Future<void> verifyCode(
    String code,
    String verificationId,
    BuildContext context,
    String phoneNumber,
    Function(bool) setError,
    ) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    await saveSession(phoneNumber, context);
}


Future<void> saveSession(String phoneNumber, BuildContext context) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  String? existingSession = await databaseHelper.getSession();

  if (existingSession != null) {
    await db.collection('sessions').doc(existingSession).delete();
    await databaseHelper.deleteSession(phoneNumber);
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