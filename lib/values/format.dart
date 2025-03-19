import 'package:flutter/services.dart';

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    String formatted = _applyPhoneMask(text);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _applyPhoneMask(String text) {
    if (text.length < 11) {
      return text;
    }

    return '(${text.substring(0, 2)})${text.substring(2, 3)} ${text.substring(3, 7)}-${text.substring(7)}';
  }

  static String unmask(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r"\D"), '');
  }
}

String reformatPhoneNumber(String phoneNumber) {
  String cleaned = phoneNumber.replaceAll(RegExp(r'\D'), '');

  if (cleaned.length == 13) {
    return '(${cleaned.substring(2, 4)})${cleaned.substring(4, 5)} ${cleaned.substring(5, 9)}-${cleaned.substring(9, 13)}';
  }

  return phoneNumber;
}