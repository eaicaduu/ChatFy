import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contatos")),
      body: Center(
        child: Text("Aqui você pode adicionar ou iniciar novas conversas."),
      ),
    );
  }
}
