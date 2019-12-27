import 'package:shared_preferences/shared_preferences.dart';

class SaveGame {
  static Future<bool> save(nextText) async {
    final prefs = await SharedPreferences.getInstance();

    final key = 'nextText';

    final value = prefs.setInt(key, nextText);
    print('save: $value');

    return value;
  }

  // static Future<int> read() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   final key = 'nextText';

  //   final value = prefs.getInt(key) ?? 0;
  //   print('read: $value');

  //   return value;
  // }
}
