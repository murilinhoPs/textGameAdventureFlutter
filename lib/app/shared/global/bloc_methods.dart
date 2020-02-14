import 'package:flutter/widgets.dart';
import 'package:text_adventure_app/app/shared/global/app_bloc.dart';
import 'package:text_adventure_app/app/shared/models/model.dart';
import 'package:text_adventure_app/app/shared/services/playerPrefs.dart';

import '../../app_module.dart';

class BlocMethods {
  static final SaveGame _playerPrefs = SaveGame();

  static final appBloc = AppModule.to.bloc<AppBloc>();

   static Future<void>  readPlayerPrefs(BuildContext context) async {
    await _playerPrefs.read();

    appBloc.setNextText(_playerPrefs.readValue);
  }

  static void changeAdventureState(
      BuildContext context, AdventureList history, int itemIndex) {
    appBloc.setChoiceState(
        history.adventure[appBloc.nextValue].options[itemIndex].setState);

    if (appBloc.nextValue < history.adventure.length) {
      // MUDANDO o nextText
      appBloc.setNextText(
          history.adventure[appBloc.nextValue].options[itemIndex].nextText - 1);
    } else {
      // MUDANDO o nextTextAdventureBloc
      appBloc.setNextText(0);
    }
    // SALVANDO o nextText
    _playerPrefs.save(appBloc.nextValue);
  }
}
