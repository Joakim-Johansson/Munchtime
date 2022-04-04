import 'package:crunchtime/widgets/RecipeInformation.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipesState();
}

class _RecipesState extends State<RecipePage> {
  int rating = 3;

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
              child: Image.asset(
                'assets/images/carbonara.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            alignment: Alignment.topCenter,
          ),
          SingleChildScrollView(
            child: RecipeInformation(),
          ),
        ],
      ),
    );
  }
}
