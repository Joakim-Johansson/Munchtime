import 'package:flutter/material.dart';

class RecipeInformation extends StatelessWidget {
  final tempIngredients = [
    "600g Spaghetti",
    "20g Egg",
    "100g Parmiggiano Reggiano",
    "500g Pork",
    "10g Garlic",
    "300g Cream",
    "10g Garlic",
    "300g O2W",
    "10g Garlic",
    "300g O2W",
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
              Text("Tasty Carbonara"),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tempIngredients.length * 2,
                  itemBuilder: ((context, index) => getData(context, index))),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget getData(BuildContext context, int i) {
    if (i.isOdd) return const Divider();
    final index = i ~/ 2;
    return Text(tempIngredients[index]);
  }
}
