import 'package:flutter/material.dart';

class ConversationModule extends StatelessWidget {
  const ConversationModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Sem conversas",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
