// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crunchtime/views/ProfileEdit.dart';
import 'package:crunchtime/widgets/RecipeListFutureHorizontal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../provider/auth.dart';

class Profile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  Color climateColor(int climateGrade) {
    if (climateGrade == 1) {
      return Color.fromARGB(255, 232, 129, 129);
    } else if (climateGrade == 2) {
      return Color.fromARGB(255, 232, 177, 129);
    } else if (climateGrade == 3) {
      return Color.fromARGB(255, 232, 223, 129);
    } else if (climateGrade == 4) {
      return Color.fromARGB(255, 196, 232, 129);
    } else if (climateGrade == 5) {
      return Color.fromARGB(255, 146, 232, 129);
    }

    return Color.fromARGB(255, 0, 0, 0);
  }

  int climateGrade = 1;
  int recipeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontFamily: 'Pattaya',
              fontSize: 30,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/hills4.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(22, 22, 22, 2),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL!),
                      radius: 80,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22, 14, 22, 4),
                  child: Text(
                    user.displayName!,
                    style: TextStyle(
                      color: Color.fromARGB(255, 27, 67, 50),
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
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
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: recipeCount.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 48, 48, 48))),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: FaIcon(
                                        FontAwesomeIcons.book,
                                        color: Color.fromARGB(255, 48, 48, 48),
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
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Container(
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
                              color: climateColor(climateGrade)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: climateGrade.toString() + "/5",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 48, 48, 48))),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: FaIcon(
                                        FontAwesomeIcons.envira,
                                        color: Color.fromARGB(255, 48, 48, 48),
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
                    ],
                  ),
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(AuthService().auth.currentUser!.uid)
                        .get(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                            padding: EdgeInsets.fromLTRB(20, 8, 12, 4),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'About me:\n',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 27, 67, 50),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    TextSpan(
                                      text: snapshot.data!["bio"],
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 27, 67, 50),
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      } else {
                        return Container();
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 6, 14, 6),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEdit()),
                        );
                        // Respond to button press
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 27, 67, 50))),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 12, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Recipes:\n',
                              style: TextStyle(
                                color: Color.fromARGB(255, 27, 67, 50),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 12, 4),
                  child: SizedBox(
                    height: 200,
                    width: 1000,
                    child: RecipeListFutureHorizontal(user.uid),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
