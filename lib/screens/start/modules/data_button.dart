import 'package:flutter/material.dart';

import '../../../values/colors.dart';

class DataButton extends StatelessWidget {
  final Future<void> Function() saveUserData;

  const DataButton({super.key, required this.saveUserData});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 16,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: AppColors.global,
          borderRadius: BorderRadius.circular(12),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          highlightElevation: 0,
          onPressed: () => saveUserData(),
          child: Icon(Icons.send, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
