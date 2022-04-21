import 'package:crunchtime/data/storage.dart';
import 'package:crunchtime/widgets/RecipeInformation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RecipePage extends StatefulWidget {
  QueryDocumentSnapshot recipe;
  Storage storage = Storage();

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
}
