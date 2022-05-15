import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crunchtime/views/ProfileEdit.dart';
import 'package:crunchtime/widgets/RecipeListFutureHorizontal.dart';

import '../provider/auth.dart';

class UserProfile extends StatelessWidget {
  UserProfile({required this.user});
  DocumentSnapshot user;

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
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/hills4.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(22, 22, 22, 2),
                  child: CircleAvatar(
                    backgroundImage: Image.network(user["photo"]).image,
                    radius: 100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22, 14, 22, 14),
                  child: Text(
                    user["name"],
                    style: TextStyle(
                      color: Color.fromARGB(255, 27, 67, 50),
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 12, 4),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'About me:\n',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 27, 67, 50),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                              text: user["bio"],
                              style: TextStyle(
                                color: Color.fromARGB(255, 27, 67, 50),
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                
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
                    child: RecipeListFutureHorizontal(user.id),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
