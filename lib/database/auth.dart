import 'package:chat/screens/start/start.dart';
import 'package:flutter/material.dart';
import 'package:chat/screens/menu.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  Future<bool> isUserLoggedIn() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'app_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE sessions(id INTEGER PRIMARY KEY, user_id TEXT)',
        );
      },
      version: 1,
    );

    final db = await database;
    final List<Map<String, dynamic>> sessions = await db.query('sessions');

    return sessions.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return MenuScreen();
        } else {
          return StartScreen();
        }
      },
    );
  }
}
