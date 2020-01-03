import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:text_adventure_app/models/model.dart';

class Aventura1Json{

  AdventureList history;

   dynamic jsonResponse;

  Future<String> loadAdventureAsset1() async {
    return await rootBundle.loadString('localJson/felipeAdventure.json');
  }

  Future loadAdventure1() async {
    String jsonProduct = await loadAdventureAsset1();
    jsonResponse = json.decode(jsonProduct);
    history = AdventureList.fromJson(jsonResponse);
  }
}