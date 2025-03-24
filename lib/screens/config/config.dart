
import 'package:chat/screens/config/modules/config_selection.dart';
import 'package:flutter/material.dart';

import '../../values/colors.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: getBackgroundColor(context),
        title: Text("Configuração"),
      ),
      body: Column(
        children: [
          ConfigSelection(),
          Center(
            child: Text("Versão 0.0.01"),
          )
        ],
      ),
    );
  }
}