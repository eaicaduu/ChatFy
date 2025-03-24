import 'package:chat/values/colors.dart';
import 'package:flutter/material.dart';

class NotifyBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const NotifyBar({super.key}) : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: getBackgroundColor(context),
      title: Text("Notificações e Sons"),
    );
  }
}
