import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../values/colors.dart';
import 'theme_provider.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    String getThemeText(ThemeMode mode) {
      switch (mode) {
        case ThemeMode.light:
          return "Tema Claro";
        case ThemeMode.dark:
          return "Tema Escuro";
        case ThemeMode.system:
          return "Tema do Sistema";
      }
    }

    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: AppBar(
          backgroundColor: getBackgroundColor(context),
          title: Text("Tema e Aparência"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Alterar Tema", style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: getBackgroundColor(context),
                        title: Text("Escolha o tema"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildThemeOption(context, "Tema Claro",
                                ThemeMode.light, themeProvider),
                            _buildThemeOption(context, "Tema Escuro",
                                ThemeMode.dark, themeProvider),
                            _buildThemeOption(context, "Tema do Sistema",
                                ThemeMode.system, themeProvider),
                          ],
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.global,
                  ),
                  child: Row(
                    children: [
                      Text(getThemeText(themeProvider.themeMode),
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      SizedBox(width: 5),
                      Icon(Icons.radio_button_on_rounded, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, String title, ThemeMode mode,
      ThemeProvider themeProvider) {
    return ListTile(
      title: Text(title),
      trailing: themeProvider.themeMode == mode
          ? Icon(Icons.check, color: Colors.blue)
          : null,
      onTap: () {
        themeProvider.setTheme(mode);
        Navigator.pop(context);
      },
    );
  }
}
