import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunchtime/data/storage.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:crunchtime/widgets/RecipeInformation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../provider/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

///Recipepage displays all the information about a recipe
///
///Uses recipeinformation.dart to display the Recipes
///Needs a QueryDocumentSnapshot from firebase in order to work properly
class RecipePage extends StatefulWidget {
  Storage storage = Storage();
  Map<String, dynamic> recipe;

  RecipePage(this.recipe);

  @override
  State<RecipePage> createState() => _RecipesState();
}

class _RecipesState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 247),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Recipes',
            style: TextStyle(
              color: Color.fromARGB(255, 27, 67, 50),
              fontFamily: 'Pattaya',
              fontSize: 30,
            )),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        elevation: 0,
        actions: showbuttons() +
            <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(AuthService().auth.currentUser?.uid)
                                  .get(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  Map<String, dynamic> map = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  return SimpleDialog(
                                    title: Text('Share to group'),
                                    children: map["groups"]!
                                        .map<Widget>(
                                            (key) => SimpleDialogOption(
                                                onPressed: () async {
                                                  CollectionReference
                                                      recipeColl =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("groups")
                                                          .doc(key)
                                                          .collection(
                                                              "recipes");

                                                  DocumentSnapshot foundDoc =
                                                      await recipeColl
                                                          .doc(widget
                                                              .recipe["name"])
                                                          .get();
                                                  if (foundDoc.exists) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                content: Text(
                                                                  "Already exists in that group",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                )));
                                                  } else {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("groups")
                                                        .doc(key)
                                                        .collection("recipes")
                                                        .doc(widget
                                                            .recipe["name"])
                                                        .set({});
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                content: Text(
                                                                  "Succesfully added!",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                )));
                                                  }

                                                  Navigator.pop(context);
                                                },
                                                child: Text(key.toString())))
                                        .toList(),
                                    elevation: 10,
                                    //backgroundColor: Colors.green,
                                  );
                                } else {
                                  return Container();
                                }
                              }));
                    },
                    child: Icon(
                      Icons.share,
                      size: 26.0,
                    ),
                  )),
            ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment(0, 0.7),
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: FutureBuilder(
                  future: widget.storage.downloadURL(widget.recipe["img"]),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )),
            alignment: Alignment.topCenter,
          ),
          SingleChildScrollView(
            child: RecipeInformation(widget.recipe),
          ),
        ],
      ),
    );
  }

  void deleteRecipe() async {
    await http.delete(Uri.parse(
        "https://cohesive-photon-346611.ew.r.appspot.com/delete/" +
            widget.recipe["name"] +
            "/" +
            AuthService().auth.currentUser!.uid));

    Navigator.of(context).pushNamed("/recipelist");
  }

  List<Widget> showbuttons() {
    if (AuthService().auth.currentUser!.uid == widget.recipe["user"]) {
      return <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("/createRecipe", arguments: widget.recipe);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.trash,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 23,
                ),
                onPressed: deleteRecipe,
              ),
            )
          ]),
        )
      ];
    }
    return [Container()];
  }
}
