import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/models/tafseer.dart';
import 'package:quran_app/models/tafseer_source.dart';
import '../widgets/alert.dart';

class Network {
  Future<Map<String, dynamic>> fetchData(int page) async {
    http.Response response = await http.get(
      Uri.parse('http://api.alquran.cloud/v1/page/$page/quran-uthmani'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return Future.error('error');
  }

  Future<List<TafseerSource>> fetchTafseerSources(BuildContext context) async {
    http.Response response = await http.get(
      Uri.parse('http://api.quran-tafseer.com/tafseer'),
    );
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      return json.map((e) => TafseerSource.fromJson(e)).toList();
    }

    showSnackBar(context, message: 'خطأ في الاتصال بالانترنت');
    return Future.error('error');
  }

  Future<Tafseer> fetchTafseer(
      BuildContext context, int soraNo, int ayaNo) async {
    http.Response response = await http.get(
      Uri.parse('http://api.quran-tafseer.com/tafseer/1/$soraNo/$ayaNo'),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Tafseer.fromJson(json);
    }

    showSnackBar(context, message: 'خطأ في الاتصال بالانترنت');
    return Future.error('error');
  }
}
