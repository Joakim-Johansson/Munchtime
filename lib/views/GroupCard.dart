import 'package:flutter/material.dart';

class GroupCard extends StatefulWidget {
  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  var boxColor = Colors.blue;

  void test() {
    setState(() => {boxColor = Colors.red});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            GestureDetector(
                onTap: () => test(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  ),
                
                ),
                
            Container(
              width: 350,

              child: Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
              color: Color.fromARGB(255, 27, 67, 50).withOpacity(0.05),
              width: 3,
                ),
                ),
                  child: Column(
                    children:  [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 5),
                          child: Text(
                            "Tha mandem",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 8, 28, 21),
                               ),
                            
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 15, 5),
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 45, 106, 79),
                                borderRadius: new BorderRadius.all(Radius.elliptical(40, 40)),
                              ),
                              child: const Center(
                                child: Text(
                                  '15 Recipes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 216, 243, 220),
                                   ),
                                  )
                                  ),
                            )
                            ),
                            
                          ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 15, 5),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 199,	183,	228),
                                borderRadius: new BorderRadius.all(Radius.circular(30)),
                              ),
                              child:  Center(
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "10",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 8, 28, 21),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: Icon(Icons.person, size: 15),
                                      ),
                                    ],
                                  ),
                                )
                                  ),
                            )
                            ),
                            
                          ),
                        ],
                      ),
                    ],
                  ),
                color: Color.fromARGB(255, 183, 228, 199),
              ),
              
            ),
          ],
        ),
      ),
      
    ); //DETTA ÄR FELET OM DET INTE FUNKAR MED BILD EFTER RESTART
  }
}
