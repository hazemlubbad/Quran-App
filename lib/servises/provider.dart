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
}
