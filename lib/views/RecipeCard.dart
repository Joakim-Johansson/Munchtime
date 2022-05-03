import 'package:crunchtime/data/storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

///Shows a recipe as a small box with an image and name
///
///Needs a QueryDocumentSnapshot which it can get from firebase
///Generally used to create the lists showing different recipes
///Those pages themselves get the information from firebase
class RecipeCard extends StatefulWidget {
  Storage storage = Storage();
  Map<String, dynamic> recipe;

  RecipeCard(this.recipe);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  var boxColor = Colors.blue;

  void test() {
    setState(() => {boxColor = Colors.red});
  }

  ///The function which creates the widget itself
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
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            GestureDetector(
      
                ///When tapped it will send the user to a recipepage which uses the
                ///recipe specified in the card to build the actual recipe
                onTap: () => Navigator.of(context).pushNamed(
                      "/recipepage",
                      arguments: widget.recipe,
                    ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FutureBuilder(
                        future: widget.storage.downloadURL(widget.recipe["img"]),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
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
      
              ///Writes out the text with background at the bottom of the image
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.recipe["name"] as String,
                    style: const TextStyle(
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
      ),
    ); //DETTA ÄR FELET OM DET INTE FUNKAR MED BILD EFTER RESTART
  }
}
