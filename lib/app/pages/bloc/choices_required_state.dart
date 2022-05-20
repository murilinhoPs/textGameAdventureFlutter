import 'package:flutter/widgets.dart';
import 'package:text_adventure_app/app/shared/models/model.dart';

class ChoicesRequiredState {
  bool verifyRequiredStateKeys(
      Options options, AsyncSnapshot<Map<String, dynamic>> snapshot) {
    var newMapListFromSnapshot = List<Map<String, dynamic>>();

    if (!snapshot.hasData) return false;

    snapshot.data
        .forEach((key, value) => newMapListFromSnapshot.add({key: value}));

    return newMapListFromSnapshot.any(
      (requiredState) =>
          options.requiredState.toString() == requiredState.toString(),
    );
  }
}

/*print("MapToList: $newMapListFromSnapshot");
    print("snapshot: ${snapshot.data}");
    print("options: ${options.requiredState}");*/
