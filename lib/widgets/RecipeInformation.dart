import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Tag.dart';

class RecipeInformation extends StatelessWidget {
  QueryDocumentSnapshot recipe;
  late List<String> ingredientList;

  RecipeInformation(this.recipe) {
    ingredientList = translateIngredients(recipe["ingredients"]);
  }

  final tempInstructions = [
    "Cook Pasta",
    "Fry pork",
    "Whisk Eggs",
    "Put Cheese on top"
  ];

  List<Widget> dummylist =
      List.filled(5, Container(color: Colors.red, height: 200, width: 50));
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: MediaQuery.of(context).size.height / 2),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white.withOpacity(0.9),
          ),
          width: MediaQuery.of(context).size.width * 0.92,
          child: Column(
            children: [
              Text(
                recipe["name"],
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, height: 3),
                textAlign: TextAlign.left,
              ),
              const RatingStars(
                value: 3,
                valueLabelVisibility: false,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Tag(
                        "Eco-impact: " + recipe["Total CO2-eq"].toString(),
                        Colors.green),
                  )),
              const Align(
                alignment: Alignment(-0.95, 0),
                child: Text(
                  "Ingredients:",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, height: 2),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ingredientList.length * 2,
                    itemBuilder: ((context, index) =>
                        getIngredients(context, index))),
              ),
              const Align(
                alignment: Alignment(-0.95, 0),
                child: Text(
                  "Instructions:",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, height: 2),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tempInstructions.length * 2,
                    itemBuilder: ((context, index) =>
                        getInstructions(context, index))),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget getIngredients(BuildContext context, int i) {
    if (i.isOdd) return const Divider();
    final index = i ~/ 2;
    return Text(ingredientList[index],
        style: const TextStyle(decorationStyle: TextDecorationStyle.dotted));
  }

  Widget getInstructions(BuildContext context, int i) {
    if (i.isOdd) return const Divider();
    final index = i ~/ 2;
    return Text(
        (i / 2 + 1).toInt().toString() + ". " + tempInstructions[index]);
  }

  static List<String> translateIngredients(List<dynamic> newIngredients) {
    return newIngredients
        .map((item) => item.substring(1, item.length - 1).toString())
        .toList();
  }
}
