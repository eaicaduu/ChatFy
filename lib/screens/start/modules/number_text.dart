import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../values/colors.dart';

class NumberText extends StatefulWidget {
  final TextEditingController phoneController;

  const NumberText({super.key, required this.phoneController});

  @override
  State<NumberText> createState() => NumberTextState();
}

class NumberTextState extends State<NumberText> {
  static const platform = MethodChannel('com.example.chat/phone');
  Future<void> _getPhoneNumber() async {
    String? phoneNumber;

    try {
      final String number = await platform.invokeMethod('getPhoneNumber');
      setState(() {
        phoneNumber = number;
      });
    } catch (e) {
      SnackBar(
        content: Text("Erro ao obter o número: $e"),
      );
      phoneNumber = null;
    }

    widget.phoneController.text = phoneNumber!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextButton(
        onPressed: _getPhoneNumber,
        child: const Text(
          "Qual o meu número?",
          style: TextStyle(color: AppColors.global, fontSize: 18),
        ),
      ),
    );
  }
}
