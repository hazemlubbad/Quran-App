import 'package:quran_app/models/aya.dart';

import '../servises/asset.dart';

Set<int> jozzes = {};

class QPage {
  List<Sura> suras = [];

  Future<void> getByPage(int number) async {
    suras.clear();
    List<dynamic> pageData = await Asset().fetchData(number);
    for (int j = 0; j < pageData.length; j++) {
      if (!jozzes.contains(pageData[j]['jozz'])) {
        jozzes.add(pageData[j]['jozz']);
        print(
            "Juz(juzNo: ${pageData[j]['jozz']} , startPage: ${pageData[j]['page']}  , endPage: 0),");
      }
    }
    Set<int> surasCount = {};
    for (int i = 0; i < pageData.length; i++) {
      surasCount.add(pageData[i]['sura_no']);
    }
    for (int sura = 0; sura < surasCount.length; sura++) {
      // print(sura);
      Sura s = Sura();
      for (int j = 0; j < pageData.length; j++) {
        if (pageData[j]['sura_no'] == surasCount.elementAt(sura)) {
          s.sura.add(Aya.fromJson(pageData[j]));
        }
      }
      s.setData();
      suras.add(s);
    }
    // print("Suras :$suras");
  }

  Future<List<QPage>> getAllPages() async {
    List<QPage> pages = [];
    List<dynamic> pageData = await Asset().fetchAllData();
    // Set<int> surasNo = {};
    // for (int i = 0; i < pageData.length; i++) {
    //   surasNo.add(pageData[i]['sura_no']);
    // }
    for (int page = 1; page <= 604; page++) {
      QPage p = QPage();
      for (int sura = 1; sura <= 114; sura++) {
        // print(sura);
        Sura s = Sura();
        for (int j = 0; j < pageData.length; j++) {
          if (pageData[j]['sura_no'] == sura && pageData[j]['page'] == page) {
            // s.ayahs.add(pageData[j]['aya_text']);
            // s.ayaEmlaey.add(pageData[j]['aya_text_emlaey']);
            // s.suraName = pageData[j]['sura_name_ar'];
            // s.ayaNo.add(pageData[j]['aya_no']);
          }
        }
        p.suras.add(s);
      }
      pages.add(p);
    }
    // print("Suras :$suras");
    return pages;
  }
}

// class Sura {
//   List<String> ayahs = [];
//   List<String> ayaEmlaey = [];
//   List<int> ayaNo = [];
//   String? suraName;
//   @override
//   String toString() {
//     return "$suraName\n$ayaEmlaey ";
//   }
// }
