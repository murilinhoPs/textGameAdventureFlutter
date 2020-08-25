import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:text_adventure_app/app/shared/utils/uniqify_lists.dart';

class ChoiceStateBloc extends BlocBase {
  List<Map<String, dynamic>> _choiceState = [];

  final _choice$ = BehaviorSubject<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get choiceState => _choice$.stream;

  void setChoiceState(Map<String, dynamic> map) {
    var newChoiceState = List();

    map.forEach((key, value) {
      Map<String, dynamic> newMap = {key: value};

      newChoiceState = _choiceState..add(newMap);
    });

    _choice$.add(map);
    UniquifyLists.uniqifyList(newChoiceState);

    _choiceState = newChoiceState;
    print("newChoiceState: $_choiceState");
  }

  @override
  void dispose() {
    _choice$.close();
    super.dispose();
  }
}
