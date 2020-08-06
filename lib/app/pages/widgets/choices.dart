import 'package:flutter/material.dart';
import 'package:text_adventure_app/app/shared/models/model.dart';
import 'package:text_adventure_app/app/shared/utils/jsons_manager.dart';

import '../../app_module.dart';
import '../../shared/global/app_bloc.dart';
import '../../shared/global/bloc_methods.dart';

class ChoicesWidget extends StatefulWidget {
  final AdventureJson jsonHistory;

  const ChoicesWidget({Key key, this.jsonHistory}) : super(key: key);

  @override
  _ChoicesWidgetState createState() => _ChoicesWidgetState();
}

class _ChoicesWidgetState extends State<ChoicesWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AppModule.to.bloc<AppBloc>().choiceState,
        builder: (context, choiceStateSnapshot) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              primary: false,
              physics: null,
              childAspectRatio: 4.5,
              crossAxisCount: 1,
              shrinkWrap: true,
              // crossAxisSpacing: 20,
              mainAxisSpacing: 0,
              children: choicesButtons(choiceStateSnapshot),
            ),
          );
        });
  }

  choicesButtons(AsyncSnapshot<Map<String, dynamic>> choiceStateSnapshot) {
    var adventureOptions = widget.jsonHistory.adventureList
        .adventure[AppModule.to.bloc<AppBloc>().nextValue].options;

    return adventureOptions.map(
      (options) {
        if (options.requiredState == null) {
          return choiceButton(context, options);
        } else {
          return BlocMethods.verifyChoiceStates(
                  options: options, snapshot: choiceStateSnapshot)
              ? choiceButton(context, options)
              : Container();
        }
      },
    ).toList();
  }

  Widget choiceButton(context, Options item) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
      ),
      splashColor: Colors.amber[300],
      padding: EdgeInsets.all(5),
      child: Text(
        item.text,
        style: TextStyle(fontSize: 16, color: Colors.grey[850]),
      ),
      onPressed: () {
        BlocMethods.changeAdventureState(
          history: widget.jsonHistory.adventureList,
          itemIndex: item.index,
        );
      },
    );
  }
}
