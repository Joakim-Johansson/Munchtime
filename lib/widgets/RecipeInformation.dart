import 'package:flutter/material.dart';

import 'Tag.dart';

///Is the scrollable part of RecipePage
///
///Creates a column which contains all the parts of a recipe
class RecipeInformation extends StatefulWidget {
  Map<String, dynamic> recipe;
  late String name;
  late String description;
  late String climateGrade;
  late List<String> ingredientList;
  late List<String> instructionList;
  late List<String> nutrition;
  late int originalPortions;

  RecipeInformation(this.recipe);
  @override
  State<RecipeInformation> createState() => _RecipeInformationState();
}

class _RecipeInformationState extends State<RecipeInformation> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.name = widget.recipe["name"];
      widget.description = widget.recipe["description"];
      // widget.description =
      // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ullamcorper arcu accumsan nulla gravida hendrerit. Aliquam fringilla massa quis congue tincidunt. Ut dolor mi, consequat eget tortor nec, porttitor tristique libero. Vivamus sit amet nisi fe";
      widget.climateGrade = widget.recipe["Climate Grade"];
      widget.ingredientList =
          translateIngredients(widget.recipe["ingredients"]);
      widget.instructionList =
          translateDynamicList(widget.recipe["instructions"]);
      widget.nutrition = translateDynamicList(widget.recipe["nutrition"]);
      widget.originalPortions = widget.recipe["portions"];
    } catch (e) {
      widget.name = "Load Failed";
      widget.description = "";
      widget.climateGrade = "";
      widget.ingredientList = [];
      widget.instructionList = [];
      widget.nutrition = ["", "", "", ""];
      widget.originalPortions = 2;
    }
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
                widget.name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, height: 3),
                textAlign: TextAlign.left,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Tag(
                        "Climate Grade: " + widget.climateGrade, Colors.green),
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Tag(widget.nutrition[0] + "g", Color.fromARGB(255, 149, 213, 178)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Tag(widget.nutrition[1] + "g", Color.fromARGB(255, 149, 213, 178)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Tag(widget.nutrition[2] + "g", Color.fromARGB(255, 149, 213, 178)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Tag(widget.nutrition[3], Color.fromARGB(255, 149, 213, 178)),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 3,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: "Cambria",
                  ),
                ),
              ),
              const Divider(
                thickness: 3,
              ),
              Center(
                  child:
                      Text("Portions: " + widget.originalPortions.toString())),
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
                    itemCount: widget.ingredientList.length * 2,
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
                    itemCount: widget.instructionList.length * 2,
                    itemBuilder: ((context, index) =>
                        getInstructions(context, index))),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  ///Builds the list of ingredients using itembuilder
  Widget getIngredients(BuildContext context, int i) {
    if (i.isOdd) return const Divider();
    final index = i ~/ 2;
    return Text(widget.ingredientList[index],
        style: const TextStyle(decorationStyle: TextDecorationStyle.dotted));
  }

  ///Works similarly to getIngredients
  Widget getInstructions(BuildContext context, int i) {
    if (i.isOdd) return const Divider();
    final index = i ~/ 2;
    return Text(
        (i / 2 + 1).toInt().toString() + ". " + widget.instructionList[index]);
  }

  ///Builds a list containing all the ingredients to display
  static List<String> translateIngredients(List<dynamic> newIngredients) {
    return newIngredients
        .map((item) => item.substring(1, item.length - 1).toString())
        .toList();
  }

  ///Builds a list containing all the instrucions to display
  static List<String> translateDynamicList(List<dynamic> newInstructions) {
    return newInstructions.map((item) => item.toString()).toList();
  }
}
