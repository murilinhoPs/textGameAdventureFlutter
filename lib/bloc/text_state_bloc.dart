import 'package:flutter/material.dart';

class TextState extends ChangeNotifier {
  int _nextText = 0;

  int get nextText => _nextText;

  void setNextText(int next){
    _nextText = next;

    notifyListeners();
  }
}
