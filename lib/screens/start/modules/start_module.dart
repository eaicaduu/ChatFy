import 'package:flutter/material.dart';
import '../../../values/colors.dart';

class StartModule extends StatelessWidget {
  const StartModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.global,
                AppColors.global,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.white, width: 6),
          ),
          child: Center(
            child: Icon(
              Icons.chat_rounded,
              size: 120,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "ChatFy",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppColors.global,
            letterSpacing: 2.0,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          "Aplicativo de mensagens rápido e seguro.",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.global,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
