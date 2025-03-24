import 'package:flutter/material.dart';
import '../../../values/colors.dart';
import '../../../values/format.dart';
import 'number_text.dart';

class NumberModule extends StatelessWidget {
  final TextEditingController phoneController;
  final FocusNode focusNode;

  const NumberModule({
    super.key,
    required this.phoneController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.perm_phone_msg_rounded,
            size: 120,
            color: AppColors.global,
          ),
          const SizedBox(height: 10),
          const Text(
            "Insira seu número de telefone",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: phoneController,
              focusNode: focusNode,
              maxLength: 15,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [PhoneFormatter()],
              decoration: InputDecoration(
                hintText: "Seu número de telefone",
                counterText: "",
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.grey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.global, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.global, width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.global, width: 1.5),
                ),
              ),
            ),
          ),
          NumberText(phoneController: phoneController),
        ],
      ),
    );
  }
}
