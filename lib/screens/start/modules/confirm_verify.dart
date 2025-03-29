import 'package:chat/screens/start/data.dart';
import 'package:chat/values/navigate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../database/database.dart';
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
    navigateReplacement(context, DataScreen());
  }
}

Future<String> getDeviceId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? deviceId = prefs.getString('deviceId');

  if (deviceId == null) {
    deviceId = Uuid().v4();
    await prefs.setString('deviceId', deviceId);
  }

  return deviceId;
}
