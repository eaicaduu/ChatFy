import 'package:chat/values/colors.dart';
import 'package:flutter/material.dart';

class ConfigBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const ConfigBar({super.key}) : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: getBackgroundColor(context),
      title: Text("Configuração"),
    );
  }
}
