import 'package:flutter/material.dart';
import '../../../values/colors.dart';
import '../../../values/navigate.dart';
import '../number.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: GestureDetector(
        onTap: () {
          navigate(context, NumberScreen());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                AppColors.global,
                AppColors.global.withValues(alpha: 0.8)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.global.withValues(alpha: 0.5),
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "Continuar",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
