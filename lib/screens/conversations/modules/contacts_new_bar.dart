import 'package:flutter/material.dart';

import '../../../values/colors.dart';

class NewContactsBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const NewContactsBar({super.key})
      : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: getBackgroundColor(context),
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, size: 32,),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text("Novo Contato", style: const TextStyle(fontSize: 22)),
          Text("Salvar", style: const TextStyle(fontSize: 22, color: Colors.grey)),
        ],
      ),
    );
  }
}
