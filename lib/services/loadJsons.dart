import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:text_adventure_app/models/model.dart';

class Aventura1Json{

  static dynamic jsonResponse;

  static Future<String> loadAdventureAsset1() async {
    return await rootBundle.loadString('localJson/adventure1.json');
  }

  static Future loadAdventure1() async {
    String jsonProduct = await loadAdventureAsset1();
    jsonResponse = json.decode(jsonProduct);
  }
}