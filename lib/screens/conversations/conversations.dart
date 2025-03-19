import 'package:chat/screens/conversations/modules/conversation_module.dart';
import 'package:chat/screens/conversations/modules/conversations_bar.dart';
import 'package:chat/values/colors.dart';
import 'package:flutter/material.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: ConversationsBar(),
      body: ConversationModule(),
    );
  }
}
