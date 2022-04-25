import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crunchtime/widgets/RecipeListFuture.dart';

class RecipeList extends StatefulWidget {
  // final List<RecipeCard> dummyList = List.filled(5, RecipeCard("Carbonara"));

  Widget searchBar = Container();
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
                    widget.searchBar,
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
                        onPressed: () {
                          createSearchbar();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        body: RecipeListFuture(widget.searchTerm));
  }

  void createSearchbar() {
    setState(() {
      if (widget.searchBar is Container) {
        widget.searchBar = SizedBox(
          width: 150,
          height: 50,
          child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                search(value);
              },
              controller: widget.searchContent,
              decoration: InputDecoration(hintText: "Search")),
        );
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
}
