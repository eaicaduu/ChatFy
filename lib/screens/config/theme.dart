import 'package:chat/screens/config/modules/theme_selection.dart';
import 'package:flutter/material.dart';
import '../../values/colors.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: AppBar(
          backgroundColor: getBackgroundColor(context),
          title: Text("Tema e Aparência"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ThemeSelection()
          ],
        ),
      ),
    );
  }
}