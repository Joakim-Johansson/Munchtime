import 'package:crunchtime/views/Home.dart';
import 'package:crunchtime/views/Profile.dart';
import 'package:crunchtime/views/RecipeList.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/recipelist':
        return MaterialPageRoute(builder: (_) => RecipeList());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
    }

    return MaterialPageRoute(builder: (_) => Home()); // Default
  }
}
