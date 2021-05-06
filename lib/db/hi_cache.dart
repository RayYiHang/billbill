import 'package:shared_preferences/shared_preferences.dart';

/// 本地缓存类
class HiCache {
  SharedPreferences prefs;
  HiCache._() {
    init();
  }

  static HiCache _instance;

  HiCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }
  ///预处理
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance;
  }

  static HiCache getInstance() {
    if (_instance == null) {
      _instance = HiCache._();
    }
    return _instance;
  }

  void init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  setString(String key, String value) {
    prefs.setString(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs.setStringList(key, value);
  }

  T get<T>(String key) {
    return prefs.get(key);
  }
}