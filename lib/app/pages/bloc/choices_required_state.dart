import 'package:flutter/widgets.dart';
import 'package:text_adventure_app/app/shared/models/model.dart';

class ChoicesRequiredState {
  bool _requiredStateKeys = false;

  bool verifyRequiredStateKeys(
      Options options, AsyncSnapshot<Map<String, dynamic>> snapshot) {
    var newMapListFromSnapshot = List<Map<String, dynamic>>();

    if (snapshot.hasData)
      snapshot.data
          .forEach((key, value) => newMapListFromSnapshot.add({key: value}));

    newMapListFromSnapshot.forEach((requiredState) {
      if (options.requiredState.toString() == requiredState.toString()) {
        print("Element exists in testList $requiredState");

        _requiredStateKeys = true;
      } else {
        print("Element doesn't exists in testList $requiredState");

        _requiredStateKeys = false;
      }
    });

    return _requiredStateKeys;
  }
}

/*print("MapToList: $newMapListFromSnapshot");
    print("snapshot: ${snapshot.data}");
    print("options: ${options.requiredState}");*/
