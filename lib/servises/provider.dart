import 'package:flutter/material.dart';
import 'package:quran_app/models/bookmark.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class BookmarkProvider extends ChangeNotifier {
  late Database database;
  static const String tableName = 'bookmark';
  List<Bookmark> bookmarks = [];
  Future<void> createTable(BuildContext context) async {
    database = await createDatabase(context, [
      'CREATE TABLE bookmark ( id INTEGER PRIMARY KEY , pageNo INTEGER, suraNo INTEGER, ayaNo INTEGER)'
    ]);
  }

  Future<void> insertToBookmarks(
    BuildContext context, {
    required Bookmark bookmark,
  }) async {
    bookmarks =
        await insertToDataBase(context, database: database, bookmark: bookmark);
    notifyListeners();
  }
  // Future<void> createDatabase(BuildContext context) async {
  //   await openDatabase('q.db', version: 1, onCreate: (database, version) async {
  //     print('Database Created');
  //     await database
  //         .execute(
  //         'CREATE TABLE bookmark ( id INTEGER PRIMARY KEY , pageNo INTEGER, suraNo INTEGER, ayaNo INTEGER)')
  //         .catchError((onError) {
  //       showSnackBar(context,
  //           message: 'Error in creation${onError.toString()}');
  //       // print('Error in creation${onError.toString()}');
  //     });
  //   }, onOpen: (database) {
  //     this.database = database;
  //     getDataFromDatabase();
  //   });
  // }
  //
  // Future<void> insertToDataBase(
  //     BuildContext context, {
  //       required Bookmark bookmark,
  //     }) async {
  //   if (database != null) {
  //     await database!.transaction((txn) async {
  //       await txn
  //           .insert(tableName, bookmark.toJson(),
  //           conflictAlgorithm: ConflictAlgorithm.replace)
  //           .catchError((onError) {
  //         showSnackBar(context,
  //             message: 'Error in inserting New Record ${onError.toString()}');
  //       });
  //       // await txn
  //       //     .rawInsert(
  //       //         'INSERT INTO bookmark(id, suraNo, ayaNo) VALUES($id,$suraNo,$ayaNo)')
  //       getDataFromDatabase();
  //     });
  //   }
  // }
  //
  // deleteFromDatabase(int id) async {
  //   // await database?.rawDelete('DELETE FROM questions WHERE id=$id');
  //   await database?.delete(tableName, where: 'id=?', whereArgs: [id]);
  //   getDataFromDatabase();
  // }
  //
  // Future<void> getDataFromDatabase() async {
  //   List<Map<String, dynamic>> temp =
  //   await database!.rawQuery('SELECT * FROM $tableName');
  //   // List<Map<String, dynamic>> temp = await database!.query(tableName);
  //   bookmarks = temp.map((e) => Bookmark.fromJson(e)).toList();
  //   notifyListeners();
  // }
}
