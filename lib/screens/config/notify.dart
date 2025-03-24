import 'package:chat/screens/config/modules/notify_bar.dart';
import 'package:flutter/material.dart';

class NotifyScreen extends StatelessWidget {
  const NotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotifyBar(),
      body: Scaffold(),
    );
  }
}
