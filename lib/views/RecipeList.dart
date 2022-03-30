import 'package:flutter/material.dart';
import 'RecipeCard.dart';

class RecipeList extends StatelessWidget {
  final List<RecipeCard> dummyList = List.filled(5, RecipeCard());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
            title: Text(
              "Recipes",
              style: TextStyle(
                color: Theme.of(context).focusColor,
                fontFamily: 'Pattaya',
                fontSize: 30,
              ),
            ),
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  child: IconButton(
                    icon: Icon(Icons.search),
                    color: Theme.of(context).focusColor,
                    onPressed: () {},
                  ),
                ),
              ),
            ]),
        body: GridView.count(
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          crossAxisCount: 1,
          padding: EdgeInsets.all(10),
          children: dummyList,
        ));
  }
}
