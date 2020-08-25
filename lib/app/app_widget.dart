import 'package:flutter/material.dart';
import 'package:text_adventure_app/app/pages/game_page.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: MyHomePage(title: 'Text Adventure Demo'),
    );
  }
}
