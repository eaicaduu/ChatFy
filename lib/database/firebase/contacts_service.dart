import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ContactService {
  static const platform = MethodChannel('com.example.chat/contacts');

  static Future<List<Map<String, String>>> getContacts() async {
    final List<dynamic> contacts = await platform.invokeMethod('getContacts');
    return contacts.map((e) => Map<String, String>.from(e)).toList();
  }

  static Future<bool> checkNumberInFirebase(String phoneNumber) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    return snapshot.docs.isNotEmpty;
  }
}
