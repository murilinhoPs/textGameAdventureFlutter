import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_adventure_app/models/model.dart';
import 'package:text_adventure_app/services/playerPrefs.dart';

class TextState extends ChangeNotifier {
  int _nextText = 0;

  int get nextText => _nextText;

  void setNextText(int next) {
    _nextText = next;

    notifyListeners();
  }
}

class ChoiceState extends ChangeNotifier {
  Map<String, dynamic> _choiceState;

  Map get choiceState => _choiceState;

  void setChoiceState(Map<String, dynamic> map) {
    _choiceState = map;

    notifyListeners();
  }
}

class AdventureBloc {
  static final SaveGame playerPrefs = SaveGame();

  static Future<void> readPlayerPrefs(BuildContext context) async {
    TextState textBloc = Provider.of<TextState>(context, listen: false);

    await playerPrefs.read();

    textBloc.setNextText(playerPrefs.readValue);
    print("textBloc test: " + textBloc.nextText.toString());
  }

  static void changeAdventureState(BuildContext context, AdventureList history, int itemIndex) {
    TextState textBloc = Provider.of<TextState>(context, listen: false);
    ChoiceState choiceBloc = Provider.of<ChoiceState>(context, listen: false);

    choiceBloc.setChoiceState(
        history.adventure[textBloc.nextText].options[itemIndex].setState);

    if (textBloc.nextText < history.adventure.length) {
      // MUDANDO o nextText
      textBloc.setNextText(
          history.adventure[textBloc.nextText].options[itemIndex].nextText - 1);
    } else {
      // MUDANDO o nextText
      textBloc.setNextText(0);
    }
    // SALVANDO o nextText
    playerPrefs.save(textBloc.nextText);
  }
}
