import 'package:chat/screens/conversations/modules/contacts_new_bar.dart';
import 'package:flutter/material.dart';

import '../../values/colors.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({super.key});

  @override
  NewContactScreenState createState() => NewContactScreenState();
}

class NewContactScreenState extends State<NewContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: NewContactsBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
