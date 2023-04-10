import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getStringList(key) as String);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, json.encode(value) as List<String>);
  }
}
