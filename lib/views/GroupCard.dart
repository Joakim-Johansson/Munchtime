import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunchtime/views/Groupview.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatefulWidget {
  GroupCard({required this.group});
  DocumentSnapshot group;
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
            context, MaterialPageRoute(builder: (context) => Groupview(group: widget.group.id,)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
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
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Grupp " + widget.group.id,
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 8, 28, 21),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Respond to button press
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                      color: Color.fromARGB(255, 27, 67, 50))),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            child: Text(
                              "Leave",
                              style: TextStyle(
                                color: Theme.of(context).focusColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 45, 106, 79),
                                borderRadius: new BorderRadius.all(
                                    Radius.elliptical(40, 40)),
                              ),
                              child: Center(
                                  child: Text("15 recipes",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 216, 243, 220),
                                      )))),
                        ),
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 199, 183, 228),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Center(
                              child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.group["members"].length.toString(),
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
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              color: Color.fromARGB(255, 183, 228, 199),
            ),
          ),
        ),
      ),
    ); //DETTA ÄR FELET OM DET INTE FUNKAR MED BILD EFTER RESTART
  }
}
