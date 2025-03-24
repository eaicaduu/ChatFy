import 'package:flutter/services.dart';

class ContactService {
  static const platform = MethodChannel('com.example.chat/contacts');

  static Future<List<Map<String, String>>> getContacts() async {
    final List<dynamic> contacts = await platform.invokeMethod('getContacts');
    return contacts.map((e) => Map<String, String>.from(e)).toList();
  }
}
