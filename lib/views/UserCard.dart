// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunchtime/views/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserCard extends StatelessWidget {
  UserCard({required this.userDoc});

  DocumentSnapshot userDoc;

  Color climateColor(int climateGrade){
    if (climateGrade == 1){
      return Color.fromARGB(255, 232, 129, 129);
    }
    else if (climateGrade == 2){
      return Color.fromARGB(255, 232, 177, 129);
    }
    else if (climateGrade == 3){
      return Color.fromARGB(255, 232, 223, 129);
    }
    else if (climateGrade == 4){
      return Color.fromARGB(255, 196, 232, 129);
    }

    else if (climateGrade == 5){
      return Color.fromARGB(255, 146, 232, 129);
    }

    return Color.fromARGB(255, 0, 0, 0);

  }

  int recipeCount = 10;
  int climateGrade = 1; //temporary, vill importera från använadren

  @override
  Widget build(BuildContext context) {


    print(userDoc.id);
    return Center(
        child: GestureDetector(

          onTap: () =>  Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserProfile(user: userDoc)),
                                ),
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/slimhill.png"),
            fit: BoxFit.cover,
          ),
              borderRadius: BorderRadius.circular(7),
              color: Color.fromARGB(255, 183, 228, 199),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(1, 2), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(500)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 5,
                            offset: Offset(-1, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                            Image.network(userDoc["photo"]).image, //LÄGG TILL BASERAT PÅ ANVÄNDARE SEN
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userDoc["name"],
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Theme.of(context).focusColor)),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Container(
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.5,
                                          blurRadius: 5,
                                          offset: Offset(
                                              0, 1), // changes position of shadow
                                        ),
                                      ],
                                      color: Color.fromARGB(255, 183, 212, 228)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: recipeCount.toString(),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(255, 48, 48, 48))),
                                            WidgetSpan(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(left: 5),
                                                child: FaIcon(
                                                  FontAwesomeIcons.book,
                                                  color:
                                                      Color.fromARGB(255, 48, 48, 48),
                                                  size: 17.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 20),
                                child: Container(
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.5,
                                          blurRadius: 5,
                                          offset: Offset(
                                              0, 1), // changes position of shadow
                                        ),
                                      ],
                                      color:  climateColor(climateGrade)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: climateGrade.toString() + "/5",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(255, 48, 48, 48))),
                                            WidgetSpan(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(left: 5),
                                                child: FaIcon(
                                                  FontAwesomeIcons.envira,
                                                  color:
                                                      Color.fromARGB(255, 48, 48, 48),
                                                  size: 17.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          )),
    ));
  }
}
