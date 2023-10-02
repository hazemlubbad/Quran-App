import 'package:flutter/material.dart';
import 'package:quran_app/models/bookmark.dart';
import 'package:quran_app/widgets/alert.dart';
import 'package:sqflite/sqflite.dart';

const String tableName = 'bookmark';
Future<Database> createDatabase(
    BuildContext context, List<String> createQueries) async {
  late Database db;
  await openDatabase('q.db', version: 1, onCreate: (database, version) async {
    print('Database Created');
    for (int i = 0; i < createQueries.length; i++) {
      await database.execute(createQueries[i]).catchError((onError) {
        showSnackBar(context,
            message: 'Error in creation${onError.toString()}');
      });
    }
  }, onOpen: (database) {
    db = database;
  });
  return db;
}

Future<List<Bookmark>> insertToDataBase(
  BuildContext context, {
  required Database database,
  required Bookmark bookmark,
}) async {
  await database.transaction((txn) async {
    await txn
        .insert(tableName, bookmark.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .catchError((onError) {
      showSnackBar(context,
          message: 'Error in inserting New Record ${onError.toString()}');
    });
  });
  return getBookmarksFromDatabase(database);
}

Future<List<Bookmark>> getBookmarksFromDatabase(Database database) async {
  List<Map<String, dynamic>> temp =
      await database.rawQuery('SELECT * FROM $tableName');
  return temp.map((e) => Bookmark.fromJson(e)).toList();
}
