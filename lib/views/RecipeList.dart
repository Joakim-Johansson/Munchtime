import 'package:flutter/material.dart';
import 'RecipeCard.dart';

class RecipeList extends StatelessWidget {
  final List<RecipeCard> dummyList = List.filled(5, RecipeCard());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Recipe List"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).bottomAppBarColor,
        ),
        body: GridView.count(
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          crossAxisCount: 2,
          padding: EdgeInsets.all(10),
          children: dummyList,
        ));
  }
}
