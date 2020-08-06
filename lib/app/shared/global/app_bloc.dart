import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:text_adventure_app/app/shared/models/model.dart';

class AppBloc extends BlocBase {
  AppBloc() {
    _text$.add(_nextText);
    _requiredState$.add(_requiredStateKeys);
  }

  //  Next Narrative

  int _nextText = 0;

  final _text$ = BehaviorSubject<int>();

  int get nextValue => _text$.value;
  Stream<int> get nextText => _text$.stream;

  void setNextText(int next) {
    _nextText = next;
    _text$.add(_nextText);
  }

  // Choices

  List<Map<String, dynamic>> _choiceState = [];

  final _choice$ = BehaviorSubject<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get choiceState => _choice$.stream;

  void setChoiceState(Map<String, dynamic> map) {
    var newChoiceState = _choiceState
      ..add(map)
      ..toSet()
      ..toList();

    _choice$.add(map);
    _choiceState = newChoiceState;

    // print("choiceSubject: ${_choice$.value}");
    // print(_choiceState.toSet().toList().toString());

    // _choiceState.clear();
  }

  // Required state for next Choices

  bool _requiredStateKeys = false;

  final _requiredState$ = BehaviorSubject<bool>();

  Stream<bool> get requiredStateKeys => _requiredState$.stream;

  bool verifyRequiredStateKeys(
      Options options, AsyncSnapshot<Map<String, dynamic>> snapshot) {
    List<String> mapKeyToList =
        options.requiredState.keys.map((value) => value).toList();

    for (var listKey in mapKeyToList) {
      print("contains: ${snapshot.data.containsKey(listKey)}");

      snapshot.data.containsKey(listKey)
          ? _requiredStateKeys = true
          : _requiredStateKeys = false;
    }

    _requiredState$.add(_requiredStateKeys);

    return _requiredStateKeys;
  }

  @override
  void dispose() {
    _text$.close();
    _choice$.close();
    super.dispose();
  }
}
