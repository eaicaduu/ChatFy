import 'package:chat/screens/config/modules/cloud_bar.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloudBar(),
      body: Scaffold(),
    );
  }
}
