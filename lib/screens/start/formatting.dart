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
    if (text.length < 3) return text;
    if (text.length < 7) return '(${text.substring(0, 2)}) ${text.substring(2)}';
    if (text.length < 11) return '(${text.substring(0, 2)}) ${text.substring(2, 7)}-${text.substring(7)}';

    return '(${text.substring(0, 2)}) ${text.substring(2, 3)} ${text.substring(3, 7)}-${text.substring(7)}';
  }

  static String unmask(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'\D'), '');
  }
}
