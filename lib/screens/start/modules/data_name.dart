import 'package:flutter/material.dart';

import '../../../values/colors.dart';

class DataName extends StatelessWidget {
  final TextEditingController nameController;

  const DataName({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameController,
      maxLength: 30,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: "Nome",
        counterText: "",
        hintStyle: const TextStyle(
          fontSize: 20,
          color: Colors.grey,
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
    );
  }
}
