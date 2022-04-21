import 'package:crunchtime/views/Groups.dart';
import 'package:crunchtime/views/Home.dart';
import 'package:crunchtime/views/Profile.dart';
import 'package:crunchtime/views/RecipeList.dart';
import 'package:crunchtime/views/RecipePage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/recipelist':
        return MaterialPageRoute(builder: (_) => RecipeList());
      case '/recipepage':
        return MaterialPageRoute(
            builder: (_) => RecipePage(args as QueryDocumentSnapshot));
      case '/group':
        return MaterialPageRoute(builder: (_) => Groups());
    }

    return MaterialPageRoute(builder: (_) => Home()); // Default
  }
}
