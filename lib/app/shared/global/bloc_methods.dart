import 'package:flutter/material.dart';
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

  static void changeAdventureState({
    AdventureList history,
    int itemIndex,
  }) {
    var optionsValue = history.adventure[appBloc.nextValue].options[itemIndex];

    if (appBloc.nextValue < history.adventure.length) {
      appBloc.setNextText(optionsValue.nextText - 1);
    } else
      appBloc.setNextText(0);

    if (optionsValue.setState != null)
      appBloc.setChoiceState(optionsValue.setState);

    _playerPrefs.save(appBloc.nextValue);
  }

  static bool verifyChoiceStates({Options options, AsyncSnapshot snapshot}) {
    if (options.requiredState != null)
      return appBloc.verifyRequiredStateKeys(options, snapshot);
    else
      return false;
  }
}
