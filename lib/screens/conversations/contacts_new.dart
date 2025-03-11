
import 'package:flutter/material.dart';

class NewContactScreen extends StatelessWidget {
  const NewContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Contato'),
      ),
      body: Center(
        child: Text('Aqui você pode criar um novo contato'),
      ),
    );
  }
}