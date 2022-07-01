import 'dart:async';
import 'package:sqflite/sqflite.dart';

abstract class SqliteHelper {
  static late Database client;

  static Future connect() async {
    String dirname = await getDatabasesPath();
    String path = "${dirname}demo.db";

    client = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE scanners(id INTEGER PRIMARY KEY, value TEXT NOT NULL, type INTEGER NOT NULL)",
        );
      },
    );
  }
}
