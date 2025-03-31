import 'package:chat/screens/start/data.dart';
import 'package:chat/values/navigate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../database/data/database.dart';
import '../../../database/firebase/device.dart';
import '../../menu.dart';
import '../confirm.dart';

class PhoneAuthService {
  static const platform = MethodChannel('com.example.chat/phoneAuth');

  Future<void> sendVerificationCode(
      String phoneNumber, BuildContext context, Function onComplete) async {
    String cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    String formattedPhoneNumber = "+55$cleanedPhoneNumber";
    final String verificationId =
        await platform.invokeMethod('sendVerificationCode', {
      "phoneNumber": formattedPhoneNumber,
    });
    navigateReplacement(
        context,
        ConfirmScreen(
          phoneNumber: formattedPhoneNumber,
          verificationId: verificationId,
        ));
    onComplete();
  }

  Future<void> verifyCode(String verificationId, String smsCode,
      BuildContext context, phoneNumber, hasError) async {
    final result = await platform.invokeMethod('verifyCode', {
      "verificationId": verificationId,
      "smsCode": smsCode,
    });
    if (result == 'Usuário autenticado') {
      await saveSession(phoneNumber, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Código incorreto. Tente novamente.")));
      hasError(true);
    }
  }
}

Future<void> saveSession(String phoneNumber, BuildContext context) async {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  final String deviceId = await getDeviceId();

  DocumentSnapshot sessionSnapshot = await db.collection('sessions').doc(phoneNumber).get();

  if (sessionSnapshot.exists) {
    String? storedDeviceId = sessionSnapshot.get('deviceId');

    if (storedDeviceId != null && storedDeviceId != deviceId) {
      await db.collection('sessions').doc(phoneNumber).update({
        'status': false,
        'lastLogout': FieldValue.serverTimestamp(),
      });
    }

    await db.collection('sessions').doc(phoneNumber).update({
      'phoneNumber': phoneNumber,
      'status': true,
      'deviceId': deviceId,
      'lastLogin': FieldValue.serverTimestamp(),
    });

    await databaseHelper.saveSession(phoneNumber);
    navigateReplacement(context, MenuScreen());
  } else {
    await db.collection('sessions').doc(phoneNumber).set({
      'phoneNumber': phoneNumber,
      'status': true,
      'deviceId': deviceId,
      'lastLogin': FieldValue.serverTimestamp(),
    });

    await databaseHelper.saveSession(phoneNumber);
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
      'userUID' : user?.uid,
      'displayName': "Usuário",
      'instagram': null,
      'photoURL': null,
      'phoneNumber': phoneNumber,
    });
    navigateReplacement(context, DataScreen());
  }
}
