import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi/wifi.dart';

class Preferencias{
  static Future<List<String>> loadUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String ip = await Wifi.ip;
    return [sp.getString('k_userName') ??'', ip];
  }

  static Future<void> setUserName(String name) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('k_userName', name);
  }
}