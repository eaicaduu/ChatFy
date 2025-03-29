import 'package:flutter/material.dart';
import '../../../values/colors.dart';

class DataInstagram extends StatefulWidget {
  final TextEditingController instagramController;
  const DataInstagram({super.key, required this.instagramController});

  @override
  DataInstagramState createState() => DataInstagramState();
}

class DataInstagramState extends State<DataInstagram> {
  @override
  void initState() {
    super.initState();
    widget.instagramController.addListener(_addAtSymbol);
  }

  @override
  void dispose() {
    widget.instagramController.removeListener(_addAtSymbol);
    super.dispose();
  }

  void _addAtSymbol() {
    String text = widget.instagramController.text;

    if (text.isNotEmpty && !text.startsWith('@')) {
      widget.instagramController.text = '@$text';
      widget.instagramController.selection = TextSelection.collapsed(offset: widget.instagramController.text.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.instagramController,
      maxLength: 30,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: "Instagram (opcional)",
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
