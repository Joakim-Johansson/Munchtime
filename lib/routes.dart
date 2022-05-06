import 'package:crunchtime/views/CreateRecipe.dart';
import 'package:crunchtime/views/Groups.dart';
import 'package:crunchtime/views/Home.dart';
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
            builder: (_) => RecipePage(args as DocumentSnapshot));
      case '/group':
        return MaterialPageRoute(builder: (_) => Groups());
      case '/createRecipe':
        return MaterialPageRoute(builder: (_) =>  CreateRecipe());
    }

    return MaterialPageRoute(builder: (_) => Home()); // Default
  }
}
