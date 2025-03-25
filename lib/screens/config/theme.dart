import 'package:chat/screens/config/modules/theme_bar.dart';
import 'package:chat/screens/config/modules/theme_selection.dart';
import 'package:flutter/material.dart';
import '../../values/colors.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: ThemeBar(),
      body: ThemeSelection(),
    );
  }
}