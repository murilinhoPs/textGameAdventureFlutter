import 'package:shared_preferences/shared_preferences.dart';

class SaveGame {
  int readValue;

  final key = 'nextText';

  Future<bool> save(nextText) async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.setInt(key, nextText);
    print('savePrefs: $value');

    return value;
  }

  Future<int> read() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getInt(key) ?? 0;
    print('readPrefs: $value');

    readValue = value;

    return value;
  }

  Future<void> clearPrefs() async {
    final preferences = await SharedPreferences.getInstance();

    preferences.remove(key);
  }
}
