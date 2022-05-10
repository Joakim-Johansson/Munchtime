import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:flutter/material.dart';

///Shows a specific groups recipes
///
///Will use a recipelist version which can take sorting queries
class UserList extends StatelessWidget {
  UserList({required this.users});
  List users;

  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
            title: Text(
              "User List",
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
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    const SizedBox(),
                  ],
                ),
              ),
            ]),
        body: Column(
            children: users
                .map((e) => Container(
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("Users")
                            .doc(AuthService().auth.currentUser?.uid)
                            .get(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if(snapshot.hasData){
                                return Row(
                                children: [Text(snapshot.data!["name"])]);
                                }
                                else{
                                    return Container();
                                }

                            })))
                .toList()));
  }
}
