import 'package:chat/values/colors.dart';
import 'package:flutter/material.dart';
import 'contacts.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  ChatListScreenState createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ConversationsScreen> {

  void _openContactsScreen() {
    showModalBottomSheet(
      backgroundColor: getBackgroundColor(context),
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        margin: const EdgeInsets.only(top: 16.0),
        height: MediaQuery.of(context).size.height * 0.8,
        child: ContactsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: getBackgroundColor(context),
        title: Text("Conversas"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.add),
              iconSize: 32,
              onPressed: _openContactsScreen,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Sem conversas",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
    );
  }
}
