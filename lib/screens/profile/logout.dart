import 'package:chat/screens/start/start.dart';
import 'package:chat/values/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../database/database.dart';

void signOut(BuildContext context, String phoneNumber) async {
  final navigator = Navigator.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  await user?.delete();
  await FirebaseFirestore.instance.collection('sessions').doc(phoneNumber).delete();
  await DatabaseHelper().deleteSession(phoneNumber);

  if (!context.mounted) return;

  navigator.pushReplacement(
    MaterialPageRoute(builder: (context) => const StartScreen()),
  );
}

void confirmLogout(BuildContext context, String phoneNumber) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: getBackgroundColor(context),
      title: const Text('Deseja sair da conta?'),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: getBackgroundColor(context),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text("Cancelar",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            signOut(context, phoneNumber);
          },
          style: TextButton.styleFrom(
            backgroundColor: AppColors.global,
            foregroundColor: getBackgroundColor(context),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text("Sair",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}
