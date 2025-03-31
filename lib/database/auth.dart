import 'package:chat/screens/start/start.dart';
import 'package:flutter/material.dart';
import 'package:chat/screens/menu.dart';
import 'data/database.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  Future<bool> isUserLoggedIn() async {
    final databaseHelper = DatabaseHelper();
    String? session = await databaseHelper.getSession();
    return session != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return const MenuScreen();
        } else {
          return const StartScreen();
        }
      },
    );
  }
}
