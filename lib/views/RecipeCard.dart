import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({Key? key}) : super(key: key);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  var boxColor = Colors.blue;

  void test() {
    setState(() => {boxColor = Colors.red});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(
              7.0,
              35.0,
            ),
            blurRadius: 6.0,
            spreadRadius: -15.0,
          ),
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GestureDetector(
              onTap: () => Navigator.of(context).pushNamed("/recipepage"),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/images/carbonara.jpg',
                  ),
                ),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(15)),
              color: Colors.black.withOpacity(0.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Tasty Carbonara",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ); //DETTA ÄR FELET OM DET INTE FUNKAR MED BILD EFTER RESTART
  }
}
