import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'GroupCard.dart';

class Groups extends StatelessWidget {
  Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "Groups",
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontFamily: 'Pattaya',
              fontSize: 30,
            ),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("Users")
                .doc(AuthService().auth.currentUser?.uid)
                .get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                DocumentSnapshot x = snapshot.data!;
                Map<String, dynamic> data = x.data() as Map<String, dynamic>;

                return Center(
                  child: Column(
                    children: !data.containsKey("groups")
                        ? [Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                          child: Container(
                              child: Text("You haven't joined any groups yet."),
                            ),
                        )]
                        : x["groups"].map<Widget>((e) {
                            return FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("groups")
                                    .doc(e)
                                    .get(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return GroupCard(group: snapshot.data!);
                                  } else {
                                    return Container();
                                  }
                                });
                          }).toList(),
                  ),
                );
              } else {
                return Container();
              }
            }));
  }
}
