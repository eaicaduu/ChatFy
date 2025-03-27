import 'package:flutter/services.dart';

class PhoneService {
  static const platform = MethodChannel('com.example.chat/phone');

  static Future<String> getPhoneNumber() async {
    final phoneNumber = await platform.invokeMethod('getPhoneNumber');
    return phoneNumber;
  }
}