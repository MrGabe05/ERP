import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> database() async {
    final String path = join(await getDatabasesPath(), 'database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            company TEXT NOT NULL,
            username TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE inventories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            description TEXT NOT NULL,
            store TEXT NOT NULL,
            warehouse TEXT NOT NULL,
            inventoryType TEXT NOT NULL,
            date TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<bool> checkUser(String company, String username) async {
    final Database db = await database();
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'company = ? AND username = ?',
      whereArgs: [company, username],
    );

    return result.isNotEmpty;
  }

  static Future<bool> checkPassword(String company, String username, String password) async {
    final Database db = await database();
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'company = ? AND username = ? AND password = ?',
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }

  static Future<void> registerUser(String username, String password, String company) async {
    final Database db = await database();

    await db.insert(
      'users',
      {
        'company': company,
        'username': username,
        'password': password,
      },
    );
  }
}