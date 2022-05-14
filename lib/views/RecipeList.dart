import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crunchtime/widgets/RecipeListFuture.dart';

///Shows a List of recipes
///
///Gets recipes from firebase and displays them using recipecards
///This is the main way to explore new recipes
///Links to Recipepage and createrecipe
///Is accessed by the bottom bar
class RecipeList extends StatefulWidget {
  // final List<RecipeCard> dummyList = List.filled(5, RecipeCard("Carbonara"));

  Widget searchBar = Container();
  Widget icon = const Icon(Icons.search);
  String searchTerm = "all";
  TextEditingController searchContent = TextEditingController();

  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,

        ///Top information
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
                    ///Button for adding recipes
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        color: Theme.of(context).focusColor,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed("/createRecipe")
                              .then(onGoBack);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),

                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Row(children: [
                        widget.searchBar,
                        IconButton(
                          icon: widget.icon,
                          color: Theme.of(context).focusColor,
                          onPressed: () {
                            createSearchbar();
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ]),
        body: RecipeListFuture("/" + widget.searchTerm));
  }

  void createSearchbar() {
    setState(() {
      if (widget.searchBar is Container) {
        widget.icon = const Icon(Icons.clear);
        widget.searchBar = SizedBox(
          width: 150,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                search(value);
              },
              controller: widget.searchContent,
              decoration:
                  const InputDecoration(hintText: "Search", border: InputBorder.none),
            ),
          ),
        );
      } else {
        widget.icon = const Icon(Icons.search);
        widget.searchBar = Container();
        widget.searchContent.text = "";
        search("");
      }
    });
  }

  void search(String value) {
    setState(() {
      if (value == "") {
        widget.searchTerm = "all";
      } else {
        widget.searchTerm = value;
      }
    });
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
}
