import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_adventure_app/app/pages/game_page.dart';
import 'package:text_adventure_app/app/shared/global/text_state_bloc.dart';

class AppWidget extends StatelessWidget {
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
