import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:text_adventure_app/app/pages/bloc/choices_state.dart';
import 'package:text_adventure_app/app/pages/bloc/narrative_text.dart';
import 'package:text_adventure_app/app/shared/models/model.dart';
import 'package:text_adventure_app/app/shared/utils/jsons_manager.dart';

import '../../app_module.dart';
import '../../shared/global/bloc_methods.dart';

class ChoicesWidget extends StatefulWidget {
  final AdventureJson jsonHistory;

  const ChoicesWidget({Key key, this.jsonHistory}) : super(key: key);

  @override
  _ChoicesWidgetState createState() => _ChoicesWidgetState();
}

class _ChoicesWidgetState extends State<ChoicesWidget> {
  final blocMethods = AppModule.to.getDependency<BlocMethods>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AppModule.to.bloc<ChoiceStateBloc>().choiceState,
        builder: (context, choiceStateSnapshot) {
          return Container(
            padding: const EdgeInsets.only(top: 15.0),
            margin: EdgeInsets.only(top: 15.0),
            child: ListView(
              primary: false,
              physics: null,
              shrinkWrap: true,
              children: choicesButtons(choiceStateSnapshot),
              //childAspectRatio: 4.5,
              //crossAxisCount: 1,
              // crossAxisSpacing: 20,
              //mainAxisSpacing: 1,
            ),
          );
        });
  }

  choicesButtons(AsyncSnapshot<Map<String, dynamic>> choiceStateSnapshot) {
    var adventureOptions = widget.jsonHistory.adventureList
        .adventure[AppModule.to.bloc<NarrativeTextBloc>().nextValue].options;

    return adventureOptions.map(
      (option) {
        if (option.requiredState == null ||
            blocMethods.verifyChoiceStates(
                options: option, snapshot: choiceStateSnapshot)) {
          return choiceButton(context, option);
        }
        return Container();
      },
    ).toList();
  }

  Widget choiceButton(context, Options item) {
    return FlatButton(
      shape: Border(
        top: BorderSide(color: Colors.redAccent[200], width: 2.5),
      ),
      splashColor: Colors.amber[300],
      padding: EdgeInsets.only(bottom: 25, top: 10.0),
      child: Container(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.remove,
              color: Colors.red[600],
              size: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 3.0,
              ),
              width: MediaQuery.of(context).size.width * 0.65,
              child: Text(
                item.text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        blocMethods.changeAdventureState(
          history: widget.jsonHistory.adventureList,
          itemIndex: item.index,
        );
      },
    );
  }
}
