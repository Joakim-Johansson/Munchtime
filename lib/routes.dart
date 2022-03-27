import 'package:crunchtime/views/Home.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
    }

    return MaterialPageRoute(builder: (_) => Home()); // Default
  }
}
