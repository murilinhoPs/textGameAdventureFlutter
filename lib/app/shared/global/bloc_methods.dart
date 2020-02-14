import 'package:flutter/widgets.dart';
import 'package:text_adventure_app/app/shared/global/app_bloc.dart';
import 'package:text_adventure_app/app/shared/models/model.dart';
import 'package:text_adventure_app/app/shared/services/playerPrefs.dart';

import '../../app_module.dart';

class BlocMethods {
  final SaveGame playerPrefs = SaveGame();

  final appBloc = AppModule.to.bloc<AppBloc>();

  Future<void> readPlayerPrefs(BuildContext context) async {
    await playerPrefs.read();

    appBloc.setNextText(playerPrefs.readValue);
  }

  void changeAdventureState(
      BuildContext context, AdventureList history, int itemIndex) {
    appBloc.setChoiceState(
        history.adventure[appBloc.nextValue].options[itemIndex].setState);

    if (appBloc.nextValue < history.adventure.length) {
      // MUDANDO o nextText
      appBloc.setNextText(
          history.adventure[appBloc.nextValue].options[itemIndex].nextText - 1);
    } else {
      // MUDANDO o nextText
      appBloc.setNextText(0);
    }
    // SALVANDO o nextText
    playerPrefs.save(appBloc.nextText);
  }
}
