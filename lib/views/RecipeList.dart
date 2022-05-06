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
  Widget icon = Icon(Icons.search);
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
                          Navigator.of(context).pushNamed("/createRecipe");
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
        body: StreamBuilder(
            stream: instance.collection("Recipes").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    crossAxisCount: 1,
                    padding: EdgeInsets.all(10),
                    children:
                        snapshot.data!.docs.map((e) => RecipeCard(e)).toList());
              }
              return Container();
            }));
  }
}
