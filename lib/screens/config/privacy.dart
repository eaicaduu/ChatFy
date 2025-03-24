import 'package:chat/screens/config/modules/privacy_bar.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrivacyBar(),
      body: Scaffold(),
    );
  }
}
