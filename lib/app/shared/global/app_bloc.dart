import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class AppBloc extends BlocBase {
  int _nextText = 0;

  final _text$ = BehaviorSubject<int>();

  int get nextValue => _text$.value;
  Stream<int> get nextText => _text$.stream;

  void setNextText(int next) {
    _nextText = next;
    _text$.add(_nextText);
  }

  Map<String, dynamic> _choiceState;

  final _choice$ = BehaviorSubject<Map<String, dynamic>>();

  Map<String, dynamic> get choiceValue => _choice$.value;

  Stream<Map<String, dynamic>> get choiceState => _choice$.stream;

  void setChoiceState(Map<String, dynamic> map) {
    _choiceState = map;

    _choice$.add(_choiceState);
  }

  @override
  void dispose() {
    _text$.close();
    _choice$.close();
    super.dispose();
  }
}
