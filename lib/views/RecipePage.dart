import 'package:crunchtime/data/storage.dart';
import 'package:crunchtime/widgets/RecipeInformation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
        title: const Text('Recipes',
            style: TextStyle(
              color: Color.fromARGB(255, 27, 67, 50),
              fontFamily: 'Pattaya',
              fontSize: 30,
            )),
        centerTitle: true,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: CircleAvatar(
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              CircleAvatar(
                child: IconButton(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  onPressed: deleteRecipe,
                ),
              )
            ]),
          )
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
                      return Container(
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

  void deleteRecipe() {
    http.get(
        Uri.parse("https://cohesive-photon-346611.ew.r.appspot.com/search"));
    Navigator.pop(context);
    setState(() {});
  }
}
