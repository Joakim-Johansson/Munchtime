import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crunchtime/views/ProfileEdit.dart';
import 'package:crunchtime/widgets/RecipeListFutureHorizontal.dart';

import '../provider/auth.dart';

class Profile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

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
                  padding: EdgeInsets.fromLTRB(22, 22, 22, 2),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL!),
                    radius: 100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22, 14, 22, 14),
                  child: Text(
                    user.displayName!,
                    style: TextStyle(
                      color: Color.fromARGB(255, 27, 67, 50),
                      fontSize: 30,
                    ),
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
