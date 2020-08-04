import 'package:flutter/widgets.dart';
import 'package:text_adventure_app/app/shared/global/app_bloc.dart';
import 'package:text_adventure_app/app/shared/models/model.dart';
import 'package:text_adventure_app/app/shared/utils/playerPrefs.dart';

import '../../app_module.dart';

// SET BLOC Values - COMUNICAÇÃO entre a View e o Bloc
class BlocMethods {
  static final SaveGame _playerPrefs = SaveGame();

  static final appBloc = AppModule.to.bloc<AppBloc>();

  static Future<void> readPlayerPrefs(BuildContext context) async {
    await _playerPrefs.read();

    appBloc.setNextText(_playerPrefs.readValue);
  }

  static void changeAdventureState(
      BuildContext context, AdventureList history, int itemIndex) {
    if (history.adventure[appBloc.nextValue].options[itemIndex].setState !=
        null) {
      appBloc.setChoiceState(
          history.adventure[appBloc.nextValue].options[itemIndex].setState);
    }

    if (appBloc.nextValue < history.adventure.length) {
      appBloc.setNextText(
          history.adventure[appBloc.nextValue].options[itemIndex].nextText - 1);
    } else {
      appBloc.setNextText(0);
    }

    _playerPrefs.save(appBloc.nextValue);
  }
}
