import 'package:chat/values/colors.dart';
import 'package:flutter/material.dart';

class ThemeBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const ThemeBar({super.key}) : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: getBackgroundColor(context),
        title: Text("Tema e Aparência"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
