import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:crunchtime/views/Groupview.dart';
import 'package:crunchtime/views/UserList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///Displays short information about a group in a box
///
///Shows which groups the user is a part of
///Show name member amount and how many recipes has been shared
///It also has a leave button
///Clicking the group shows all the shared recipes
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

  Future<bool> LeaveGroup(User user, String groupCode) async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('groups')
        .where("code", isEqualTo: groupCode)
        .get();

    if (snap.docs.isNotEmpty) {
      DocumentSnapshot group = snap.docs[0];
      await FirebaseFirestore.instance.collection('groups').doc(group.id).set({
        "members": FieldValue.arrayRemove([AuthService().auth.currentUser!.uid])
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(AuthService().auth.currentUser?.uid)
          .set({
        "groups": FieldValue.arrayRemove([groupCode])
      }, SetOptions(merge: true));
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Groupview(
                      name: widget.group["name"],
                      group: widget.group["code"],
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: 400,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(
                  color:
                      const Color.fromARGB(255, 27, 67, 50).withOpacity(0.05),
                  width: 3,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 10.0, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.group["name"],
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 8, 28, 21),
                          ),
                        ),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () async {
                                await LeaveGroup(
                                    AuthService().auth.currentUser!,
                                    widget.group["name"]);
                                setState(() {});
                                return;
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 27, 67, 50))),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 5),
                          child: Container(
                              height: 46,
                              width: 100,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(
                                        1, 2), // changes position of shadow
                                  ),
                                ],
                                color: const Color.fromARGB(255, 45, 106, 79),
                                borderRadius: new BorderRadius.all(
                                    const Radius.elliptical(40, 40)),
                              ),
                              child: Center(
                                  child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("groups")
                                          .doc(widget.group.id)
                                          .collection("recipes")
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              snapshot.data!.docs.length
                                                      .toString() +
                                                  " recipes",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 216, 243, 220),
                                              ));
                                        } else
                                          return Container();
                                      }))),
                        ),
                        GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserList(
                                        users: widget.group["members"])),
                              );
                            },
                            child: Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 199, 183, 228),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(
                                        1, 2), // changes position of shadow
                                  ),
                                ],
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(30)),
                              ),
                              child: Center(
                                  child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: widget.group["members"].length
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: const Color.fromARGB(
                                            255, 8, 28, 21),
                                      ),
                                    ),
                                    const WidgetSpan(
                                      child: Icon(Icons.person, size: 15),
                                    ),
                                  ],
                                ),
                              )),
                            )),
                        const SizedBox(
                          width: 125,
                        ),
                        TextButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                      title:
                                          Center(child: Text("Enter to Join")),
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 8, 8),
                                            child: Text(
                                              widget.group["code"],
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .focusColor,
                                                fontSize: 30,
                                              ),
                                            ),
                                          ),
                                        )
                                      ]);
                                });
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
                            padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                            child: Text(
                              "Invite",
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
                ],
              ),
              color: const Color.fromARGB(255, 183, 228, 199),
            ),
          ),
        ),
      ),
    ); //DETTA ÄR FELET OM DET INTE FUNKAR MED BILD EFTER RESTART
  }
}
