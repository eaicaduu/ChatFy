
import 'package:flutter/material.dart';

import '../../../values/colors.dart';
import 'number_send.dart';


class NumberButton extends StatelessWidget {
  final TextEditingController phoneController;
  final bool isPhoneValid;
  final bool isLoading;
  final Function(bool) setLoading;

  const NumberButton({
    super.key,
    required this.phoneController,
    required this.isPhoneValid,
    required this.isLoading,
    required this.setLoading,});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 26,
      bottom: 26,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isPhoneValid ? AppColors.global : Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: FloatingActionButton(
          onPressed: isPhoneValid
              ? () {
            String phoneNumber = phoneController.text.trim();
            showPhoneConfirmation(phoneNumber, context);
          }
              : null,
          backgroundColor: Colors.transparent,
          elevation: 0,
          highlightElevation: 0,
          child: isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Icon(Icons.send, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
