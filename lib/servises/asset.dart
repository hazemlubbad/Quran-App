import 'dart:convert';
import 'package:flutter/services.dart';

class Asset {
  Future<List<dynamic>> fetchData(int page) async {
    String result = await rootBundle.loadString('assets/hafs_smart_v8.json');
    if (result.isNotEmpty) {
      List<dynamic> ayahs = jsonDecode(result);
      List<dynamic> pageAyah =
          ayahs.where((element) => element['page'] == page).toList();
      return pageAyah;
    }
    return Future.error('error');
  }

  Future<List<dynamic>> fetchAllData() async {
    String result = await rootBundle.loadString('assets/hafs_smart_v8.json');
    if (result.isNotEmpty) {
      List<dynamic> ayahs = jsonDecode(result);
      return ayahs;
    }
    return Future.error('error');
  }
}
