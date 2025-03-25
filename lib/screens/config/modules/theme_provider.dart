import 'package:chat/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode, BuildContext context) {
    _themeMode = mode;
    notifyListeners();
    _updateSystemUI(context);
  }

  void _updateSystemUI(BuildContext context) {
    final backgroundColor = getBackgroundColor(context);
    if (_themeMode == ThemeMode.dark) {
      // Modo escuro
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    } else if (_themeMode == ThemeMode.light) {
      // Modo claro
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      // Modo sistema (tema segue o sistema)
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: backgroundColor == AppColors.backgroundDark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarIconBrightness: backgroundColor == AppColors.backgroundDark
            ? Brightness.light
            : Brightness.dark,
      ));
    }
  }
}