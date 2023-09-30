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
        // print('Error in creation${onError.toString()}');
      });
    }
    // await database
    //     .execute(
    //     'CREATE TABLE bookmark ( id INTEGER PRIMARY KEY , pageNo INTEGER, suraNo INTEGER, ayaNo INTEGER)')
    //     .catchError((onError) {
    //   showSnackBar(context,
    //       message: 'Error in creation${onError.toString()}');
    // print('Error in creation${onError.toString()}');
    // });
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
    // await txn
    //     .rawInsert(
    //         'INSERT INTO bookmark(id, suraNo, ayaNo) VALUES($id,$suraNo,$ayaNo)')
  });
  return getBookmarksFromDatabase(database);
}

// Future<List<Bookmark>> deleteFromDatabase(Database database,int id) async {
//   // await database?.rawDelete('DELETE FROM questions WHERE id=$id');
//   await database.delete(tableName, where: 'id=?', whereArgs: [id]);
// }

Future<List<Bookmark>> getBookmarksFromDatabase(Database database) async {
  List<Map<String, dynamic>> temp =
      await database.rawQuery('SELECT * FROM $tableName');
  // List<Map<String, dynamic>> temp = await database!.query(tableName);
  return temp.map((e) => Bookmark.fromJson(e)).toList();
}
