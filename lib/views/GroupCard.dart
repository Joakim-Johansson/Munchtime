import 'package:crunchtime/views/Groupview.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Groupview()));
      },
      child: Container(
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
                        Row(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 0, 5),
                                child: Text(
                                  "Grupp",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 8, 28, 21),
                                     ),
                                  
                                ),
                              ),
                            ),
                            Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(150, 10, 0, 0),
                              child: TextButton(
                              onPressed: () {      // Respond to button press
                              },
                              style: ButtonStyle(
                                
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              
                              RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 27, 67, 50))
                                  ),
                                  ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                                child: Text("Leave",
                                style: TextStyle(
                                      color: Theme.of(context).focusColor,
                                      fontSize: 14,
                                    ),),
                                ),
                              ),
                            ),
                          ),
                          ],
                          
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                              padding: EdgeInsets.fromLTRB(12, 2, 15, 5),
                              child: Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 45, 106, 79),
                                  borderRadius: new BorderRadius.all(Radius.elliptical(40, 40)),
                                ),
                                child: const Center(
                                  child: Text(
                                    '15 Recipes',
                                    style: TextStyle(
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
                                height: 36,
                                width: 36,
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
                                            fontSize: 14,
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
        
      ),
    ); //DETTA ÄR FELET OM DET INTE FUNKAR MED BILD EFTER RESTART
  }
}
