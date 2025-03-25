import 'package:chat/screens/config/modules/theme_replace.dart';
import 'package:flutter/material.dart';

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ThemeReplace()
        ],
      ),
    );
  }
}
