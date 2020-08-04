import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_adventure_app/app/shared/models/model.dart';

import '../models/model.dart';

class AdventureJson {
  AdventureList adventureList;

  final String jsonKey = "gameHistory";

  Future<String> _loadJsonAsset(String json) async {
    return await rootBundle.loadString(json);
  }

  Future<AdventureList> loadAdventure({String file}) async {
    String jsonProduct = await _loadJsonAsset(file);
    dynamic jsonResponse = json.decode(jsonProduct);

    adventureList = AdventureList.fromJson(jsonResponse);

    await _saveHistoryInPrefs(adventureList);

    adventureList = await _getHistoryFromPrefs();

    print(adventureList.adventure[0].toJson());

    return adventureList;
  }

  _saveHistoryInPrefs(AdventureList adventure) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(jsonKey, json.encode(adventure));
  }

  Future<AdventureList> _getHistoryFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    dynamic newAdventureString = json.decode(prefs.getString(jsonKey));

    var newAdventure = AdventureList.fromJson(newAdventureString);

    // print(newAdventure.adventure[1].toJson());

    return newAdventure;
  }
}
