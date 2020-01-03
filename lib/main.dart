import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_adventure_app/bloc/text_state_bloc.dart';
import 'package:text_adventure_app/pages/game_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TextState>.value(value: TextState()),
        ChangeNotifierProvider<ChoiceState>.value(
          value: ChoiceState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        home: MyHomePage(title: 'Text Adventure Demo'),
      ),
    );
  }
}
