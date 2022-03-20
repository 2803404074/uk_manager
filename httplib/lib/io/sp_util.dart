

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpUtils {
  static SpUtils? _singleton;
  static late SharedPreferences _prefs;
  static final _lock = Lock();

  static Future<SpUtils> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // 保持本地实例直到完全初始化。
          var singleton = SpUtils._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton!;
  }

  SpUtils._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getString(String key) {
    var status = _prefs.getString(key);
    return status;
  }

  static Future<bool> putString(String key, String value) {
    return _prefs.setString(key, value);
  }

  static Future<bool> putList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }
  static List<String> getList(String key) {
    return _prefs.getStringList(key)??[];
  }

  static int getInt(String key) {
    var status = _prefs.getInt(key);
    return status??0;
  }

  static Future<bool> putInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  static bool getBool(String key) {
    var status = _prefs.getBool(key);
    return status??false;
  }

  static Future<bool> putBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  static double getDouble(String key) {
    var status = _prefs.getDouble(key);
    return status??0.0;
  }

  static Future<bool> putDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  static Future<bool> removeValue(String key){
    return _prefs.remove(key);
  }
}