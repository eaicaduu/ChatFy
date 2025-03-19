
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "chat.db");
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE mensagens(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          text TEXT
        )
      ''');

        await db.execute('''
        CREATE TABLE session(
          phoneNumber TEXT PRIMARY KEY
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
          CREATE TABLE session(
            phoneNumber TEXT PRIMARY KEY
          )
        ''');
        }
      },
    );
  }


  Future<int> saveMessage(String text) async {
    final db = await database;
    return await db.insert("mensagens", {"text": text});
  }

  Future<List<Map<String, dynamic>>> getMessage() async {
    final db = await database;
    return await db.query("mensagens", orderBy: "id DESC");
  }

  Future<int> deleteMessage() async {
    final db = await database;
    return await db.delete("mensagens");
  }

  Future<void> saveSession(String phoneNumber) async {
    final db = await database;
    await db.insert("session", {"phoneNumber": phoneNumber},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getSession() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query("session");
    if (result.isNotEmpty) {
      return result.first["phoneNumber"];
    }
    return null;
  }

  Future<void> clearSession() async {
    final db = await database;
    await db.delete("session");
  }
}
