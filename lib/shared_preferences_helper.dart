import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{
  static Future<bool> setIntegerValue(String keyParam, int valueParam) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(keyParam, valueParam);
  }

  static Future<int> getIntegerValue(String keyParam) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(keyParam)??0;
  }
  static clearPreferences()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}