import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static final PrefHelper _instance = PrefHelper._();

  PrefHelper._();
  factory PrefHelper() {
    return _instance;
  }
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> quranBookMark(int soraNo, int ayaNo) async {
    await _preferences.setInt('markedSoraNo', soraNo);
    await _preferences.setInt('markedAyaNo', ayaNo);
  }
}
