import 'package:chat/values/colors.dart';
import 'package:flutter/material.dart';

class CloudBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CloudBar({super.key}) : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: getBackgroundColor(context),
      title: Text("Dados e Armazenamento"),
    );
  }
}
