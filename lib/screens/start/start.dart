import 'package:chat/screens/start/modules/start_button.dart';
import 'package:flutter/material.dart';
import 'package:chat/screens/start/modules/start_module.dart';
import '../../values/colors.dart';
import 'number.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StartButton(),
            const SizedBox(height: 50),
            const StartModule(),
          ],
        ),
      ),
    );
  }
}
