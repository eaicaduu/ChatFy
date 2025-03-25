
  import 'package:chat/values/colors.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'theme_provider.dart';

  class ThemeReplace extends StatefulWidget {
    const ThemeReplace({super.key});

    @override
    State<ThemeReplace> createState() => _ThemeReplaceState();
  }

  class _ThemeReplaceState extends State<ThemeReplace> {
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
        child: GestureDetector(
          onTap: () {
            showThemeDialog(context, themeProvider);
          },
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
        ),
      );
    }
  }

  void showThemeDialog(BuildContext context, ThemeProvider themeProvider) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: getBackgroundColor(context),
      title: Text("Escolha o tema"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildThemeOption(context, "Modo Claro", ThemeMode.light, themeProvider),
          _buildThemeOption(context, "Modo Escuro", ThemeMode.dark, themeProvider),
          _buildThemeOption(context, "Modo Sistema", ThemeMode.system, themeProvider),
        ],
      ),
    ));
  }

  Widget _buildThemeOption(BuildContext context, String title, ThemeMode mode, ThemeProvider themeProvider) {
    return ListTile(
      title: Text(title),
      trailing: themeProvider.themeMode == mode ? Icon(Icons.check, color: Colors.blue) : null,
      onTap: () {
        themeProvider.setTheme(mode, context);
        Navigator.pop(context);
      },
    );
  }
