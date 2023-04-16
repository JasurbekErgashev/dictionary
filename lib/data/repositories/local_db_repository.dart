import 'dart:io';

import 'package:dictionary/data/dto/definition.dart';
import 'package:dictionary/data/dto/eng_uzb.dart';
import 'package:dictionary/data/dto/uzb_eng.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDBRepository {
  LocalDBRepository._init();
  static final LocalDBRepository instance = LocalDBRepository._init();
  static Database? _database;

  Future<Database> getDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDirectory.path, 'dictionary.db');

    if (await File(dbPath).exists()) {
      return openDatabase(dbPath);
    }

    final data = await rootBundle.load('assets/db/dictionary.db');
    final bytes = data.buffer.asUint8List();
    await File(dbPath).writeAsBytes(bytes);

    return openDatabase(dbPath);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await getDatabase();
    return _database!;
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<List<EngUzb>> getAllEngUzbWords() async {
    final db = await database;
    var res = await db.query("eng_uzb");
    List<EngUzb> words =
        res.isNotEmpty ? res.map((w) => EngUzb.fromMap(w)).toList() : [];
    return words;
  }

  Future<List<UzbEng>> getAllUzbEngWords() async {
    final db = await database;
    var res = await db.query("uzb_eng");
    List<UzbEng> words =
        res.isNotEmpty ? res.map((w) => UzbEng.fromMap(w)).toList() : [];
    return words;
  }

  Future<List<Definition>> getAllDefinitions() async {
    final db = await database;
    var res = await db.query("definition");
    List<Definition> defs =
        res.isNotEmpty ? res.map((w) => Definition.fromMap(w)).toList() : [];
    return defs;
  }
}
