import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'RecipeCard.dart';

class Groupview extends StatelessWidget {
  String group = '';

  Groupview({required this.group});
  // final List<RecipeCard> dummyList = List.filled(5, RecipeCard("Carbonara"));

  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
            title: Text(
              "Group " + group + "recipes",
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
        body: StreamBuilder(
            stream: instance
                .collection("groups")
                .doc(group)
                .collection("recipes").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    crossAxisCount: 1,
                    padding: EdgeInsets.all(10),
                    children: snapshot.data!.docs
                        .map((e) => FutureBuilder(
                            future:
                                instance.collection("Recipes").doc(e.id).get(),
                            builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> asyncRecipe) =>
                                asyncRecipe.hasData
                                    ? RecipeCard(asyncRecipe.data!)
                                    : Container()))
                        .toList());
              } else {
                return Container();
              }
            }));
  }
}
