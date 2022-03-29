import 'package:flutter/material.dart';

class RecipeInformation extends StatelessWidget {
  final tempIngredients = [
    "600g Spaghetti",
    "20g Egg",
    "100g Parmiggiano Reggiano",
    "500g Pork",
    "10g Garlic",
    "300g Cream"
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
                "Tasty Carbonara",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tempIngredients.length * 2,
                    itemBuilder: ((context, index) => getData(context, index))),
              ),
              Text(
                  " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."),
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
