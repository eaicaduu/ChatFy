import 'package:flutter/material.dart';
import '../../../values/colors.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.global,
            border: Border.all(color: AppColors.global, width: 4),
          ),
          child: Center(
            child: Icon(
              Icons.chat_rounded,
              size: 120,
              color: getBackgroundColor(context),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "ChatFy",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppColors.global,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          "Aplicativo de mensagens rápido e seguro.",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.global,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
