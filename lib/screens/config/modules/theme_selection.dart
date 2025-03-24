import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ThemeSelection extends StatefulWidget {
  const ThemeSelection({super.key});

  @override
  State<ThemeSelection> createState() => _ThemeSelectionState();
}

class _ThemeSelectionState extends State<ThemeSelection> {

  String getThemeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return "Claro";
      case ThemeMode.dark:
        return "Escuro";
      case ThemeMode.system:
        return "Automático";
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.color_lens_outlined),
              SizedBox(width: 8),
              Text("Alterar Tema", style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text("(${getThemeText(themeProvider.themeMode)})",
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
