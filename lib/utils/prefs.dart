import 'package:shared_preferences/shared_preferences.dart';

class Prefs{
  static SharedPreferences? _preferences;
  static Future<void> createInstance()async{
    _preferences ??= await SharedPreferences.getInstance();
  }
  static SharedPreferences getInstance(){
    return _preferences!;
  }
}