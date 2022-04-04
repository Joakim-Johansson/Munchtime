import 'package:flutter/material.dart';
import 'RecipeCard.dart';

class RecipeList extends StatelessWidget {
  final List<RecipeCard> dummyList = List.filled(5, const RecipeCard());

  RecipeList({Key? key}) : super(key: key);

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
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        color: Theme.of(context).focusColor,
                        onPressed: () {
                          Navigator.of(context).pushNamed("/createRecipe");
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        color: Theme.of(context).focusColor,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        body: GridView.count(
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          crossAxisCount: 1,
          padding: const EdgeInsets.all(10),
          children: dummyList,
        ));
  }
}
