import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class NarrativeTextBloc extends BlocBase {
  NarrativeTextBloc() {
    _text$.add(_nextNarrativeText);
  }

  //  Next Narrative
  int _nextNarrativeText = 0;

  final _text$ = BehaviorSubject<int>();

  int get nextValue => _text$.value;
  Stream<int> get nextNarrativeText => _text$.stream;

  void setNextNarrativeText(int next) {
    _nextNarrativeText = next;
    _text$.add(_nextNarrativeText);
  }

  @override
  void dispose() {
    _text$.close();
    super.dispose();
  }
}
