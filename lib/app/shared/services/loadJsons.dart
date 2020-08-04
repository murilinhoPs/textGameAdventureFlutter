import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:text_adventure_app/app/shared/models/model.dart';

import '../models/model.dart';

class AdventureJson {
  AdventureList history;

  dynamic jsonResponse;

  Future<String> _loadAdventureAsset1() async {
    return await rootBundle.loadString('assets/localJson/felipeAdventure.json');
  }

  Future<AdventureList> loadAdventure1() async {
    String jsonProduct = await _loadAdventureAsset1();
    jsonResponse = json.decode(jsonProduct);
    history = AdventureList.fromJson(jsonResponse);

    return history;
  }
}
