import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
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
        ],),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GestureDetector(
              onTap: () => test(),
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
              )
              ),
              
          Text(
            "Tasty Carbonara",
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.3)),
            
          ),
        ],
      ),
      
    ); //DETTA ÄR FELET OM DET INTE FUNKAR MED BILD EFTER RESTART
  }
}
