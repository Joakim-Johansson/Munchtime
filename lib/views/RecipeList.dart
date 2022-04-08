import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'RecipeCard.dart';

class RecipeList extends StatelessWidget {
  final List<RecipeCard> dummyList = List.filled(5, RecipeCard("Carbonara"));

  FirebaseFirestore instance = FirebaseFirestore.instance;

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
        body: FutureBuilder(
            future: instance.collection("Recipes").get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    crossAxisCount: 1,
                    padding: EdgeInsets.all(10),
                    children: snapshot.data!.docs
                        .map((e) => RecipeCard(e["name"]))
                        .toList());
              }
              return Container();
            }));
  }

  // Future<List<Widget>> createList() async {
  //   QuerySnapshot recipes = await instance.collection("Recipes").snapshots().map()
  // }
}
