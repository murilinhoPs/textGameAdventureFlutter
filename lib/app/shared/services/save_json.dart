import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/model.dart';
import 'loadJsons.dart';

class JsonDataLocal {
  AdventureList adventureModel;

  final String jsonKey = "gameHistory";

  final AdventureJson jsonHistory = AdventureJson();

  saveHistoryInPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    adventureModel = await jsonHistory.loadAdventure1();

    prefs.setString(jsonKey, json.encode(adventureModel));
  }

  getHistoryFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dynamic newAdventureString = json.decode(prefs.getString(jsonKey));

    adventureModel = AdventureList.fromJson(newAdventureString);

    print(adventureModel.adventure[1].toJson());
  }
}
