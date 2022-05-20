import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:text_adventure_app/app/pages/bloc/choices_required_state.dart';
import 'package:text_adventure_app/app/pages/bloc/choices_state.dart';
import 'package:text_adventure_app/app/pages/bloc/narrative_text.dart';
import 'package:text_adventure_app/app/shared/models/model.dart';
import 'package:text_adventure_app/app/shared/utils/playerPrefs.dart';

import '../../app_module.dart';

// SET BLOC Values - COMUNICAÇÃO entre a View e o Bloc
class BlocMethods {
  final SaveGame _playerPrefs = SaveGame();

  final _narrativeTextBloc = AppModule.to.bloc<NarrativeTextBloc>();

  final _choiceStateBloc = AppModule.to.bloc<ChoiceStateBloc>();

  final _choicesRequiredState =
      AppModule.to.getDependency<ChoicesRequiredState>();

  Future<void> readPlayerPrefs(BuildContext context) async {
    await _playerPrefs.read();

    _narrativeTextBloc.setNextNarrativeText(_playerPrefs.readValue);
  }

  void changeAdventureState({
    AdventureList history,
    int itemIndex,
  }) {
    var optionsValue =
        history.adventure[_narrativeTextBloc.nextValue].options[itemIndex];

    if (_narrativeTextBloc.nextValue < history.adventure.length) {
      _narrativeTextBloc.setNextNarrativeText(optionsValue.nextText - 1);
    } else
      _narrativeTextBloc.setNextNarrativeText(0);

    // SET the current choiceState for the current options
    if (optionsValue.setState != null)
      _choiceStateBloc.setChoiceState(optionsValue.setState);

    _playerPrefs.save(_narrativeTextBloc.nextValue);
  }

  // CHECK if the requiredState of the option has the correct requiredState
  bool verifyChoiceStates(
      {@required Options options, @required AsyncSnapshot snapshot}) {
    return _choicesRequiredState.verifyRequiredStateKeys(options, snapshot);
  }
}
