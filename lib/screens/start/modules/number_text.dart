import 'package:chat/screens/start/modules/number_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../values/colors.dart';

class NumberText extends StatefulWidget {
  final TextEditingController phoneController;

  const NumberText({super.key, required this.phoneController});

  @override
  State<NumberText> createState() => NumberTextState();
}

class NumberTextState extends State<NumberText> {
  Future<void> getPhoneNumber() async {
      var status = await Permission.phone.request();
      var sms = await Permission.sms.request();

      if (status.isGranted && sms.isGranted) {
        final String number = await PhoneService.getPhoneNumber();

        setState(() {
          if (number.isNotEmpty) {
            widget.phoneController.text = number;
          } else {
            String message = "Não conseguimos acessar o número do seu telefone.";

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
          }
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Permissão negada. Não é possível obter o número."),
            ),
          );
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.global,
          overlayColor: Colors.transparent,
        ),
        onPressed: getPhoneNumber,
        child: const Text(
          "Qual o meu número?",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
