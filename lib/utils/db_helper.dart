import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_1/models/model.dart';
import 'package:path/path.dart';
import 'dart:io';

class DBhelper {
  static Database? _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDatabse();
      return _database!;
    }
  }

  initDatabse() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) {
    db.execute(
        "CREATE TABLE notes(id INTEGER PRIMARY KEY, title STRING, description TEXT)");
  }

  Future<List<Notes>> getNotes() async {
    var dbclient = await db;
    final List<Map<String, Object?>> queryrequest =
        await dbclient.query('notes', orderBy: 'id');
    return queryrequest.map((e) => Notes.fromMap(e)).toList();
  }

  // Future<List<Notes>> getId() async {
  //   var dbclient = await db;
  //   final List<Map<String, Object?>> queryrequest =
  //       await dbclient.query('notes', orderBy: 'title');
  //   return queryrequest.map((e) => Notes.fromMap(e)).toList();
  // }

  Future<int> createNote(Notes notes) async {
    var dbclient = await db;
    return await dbclient.insert('notes', notes.toMap());
  }

  Future<int> deleteNote(int id) async {
    var dbclient = await db;
    return await dbclient.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateNote(Notes notes) async {
    var dbclient = await db;
    return await dbclient
        .update('notes', notes.toMap(), where: 'id= ?', whereArgs: [notes.id]);
  }
}
