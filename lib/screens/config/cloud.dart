import 'package:chat/screens/config/modules/cloud_bar.dart';
import 'package:flutter/material.dart';

class CloudScreen extends StatelessWidget {
  const CloudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloudBar(),
      body: Scaffold(),
    );
  }
}
