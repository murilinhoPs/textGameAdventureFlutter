import 'package:flutter/material.dart';
import 'package:text_adventure_app/app/pages/game_page.dart';

class Routes {
  Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => MyHomePage(),
        );
    }
  }
}
