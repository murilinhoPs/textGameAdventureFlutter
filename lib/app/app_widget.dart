import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:text_adventure_app/app/pages/game_page.dart';
import 'package:text_adventure_app/app/routes.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text Adventure ZOmbie',
      initialRoute: '/',
      onGenerateRoute: GetIt.instance<Routes>().generateRoutes,
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
