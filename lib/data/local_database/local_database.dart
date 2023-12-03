import 'package:hive_flutter/adapters.dart';

class LocalDatabase {
  static Future<void> openHiveBox() async {
    await Hive.openBox('local_data');
  }

  static final _hiveBox = Hive.box("local_data");

  static bool isBoxOpen() {
    return _hiveBox.isOpen;
  }

  static void saveUserIndex(int userIndex) {
    _hiveBox.put("userIndex", userIndex);
  }

  static void saveUserToken(String userIndex) {
    _hiveBox.put("userToken", userIndex);
  }

  static int? getUserIndex() {
    return _hiveBox.get("userIndex");
  }

  static String? getUserToken() {
    return _hiveBox.get("userToken");
  }

  static void deletUserData() {
    _deletUserIndex();
    _deletUserToken();
  }

  static void _deletUserIndex() {
    _hiveBox.delete("userIndex");
  }

  static void _deletUserToken() {
    _hiveBox.delete("userToken");
  }

  static bool isUserAuthenticated() {
    return (_hiveBox.containsKey("userIndex") &&
        _hiveBox.containsKey("userToken"));
  }
}
