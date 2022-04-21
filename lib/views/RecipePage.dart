import 'package:crunchtime/widgets/RecipeInformation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RecipePage extends StatefulWidget {
  QueryDocumentSnapshot recipe;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  RecipePage(this.recipe);

  @override
  State<RecipePage> createState() => _RecipesState();
}

class _RecipesState extends State<RecipePage> {
  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results =
        await widget.storage.ref('test').listAll();
    print(results);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    listFiles();
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
              child: Image.asset(
                'assets/images/carbonara.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
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
