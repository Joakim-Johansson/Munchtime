import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:flutter/material.dart';

///Page for creating a new group
///
///Gives the user the option to name a group with up to ten characters
class CreateGroup extends StatefulWidget {
  @override
  CreateGroupWidget createState() => CreateGroupWidget();
}

class CreateGroupWidget extends State<CreateGroup> {
  late final TextEditingController controller;
  FirebaseFirestore instance = FirebaseFirestore.instance;

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: '');
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "Create Group",
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
                  image: AssetImage("assets/images/blob4.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Enter the Group Name\n',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 27, 67, 50),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(75, 0, 75, 10),
                  child: Container(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: controller,
                      maxLines: 1,
                      maxLength: 10,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 27, 67, 50),
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 0, 80, 6),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () async {
                        String code = generateRandomString(6);
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection('groups')
                            .where("code", isEqualTo: controller.text)
                            .get();

                        if (snap.docs.isEmpty) {
                          await instance.collection("groups").doc(code).set({
                            "owner": AuthService().auth.currentUser!.uid,
                            "members": FieldValue.arrayUnion(
                                [AuthService().auth.currentUser!.uid]),
                            "name": controller.text,
                            "code": code
                            // add id
                          });

                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(AuthService().auth.currentUser?.uid)
                              .set({
                            "groups": FieldValue.arrayUnion([code]),
                          }, SetOptions(merge: true));

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    "Succesfully created group!",
                                    style: TextStyle(color: Colors.white),
                                  )));

                          controller.clear();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    "A group with that code already exists",
                                    style: TextStyle(color: Colors.black),
                                  )));
                        }

                        controller.clear();

                        // Check if group id is unique

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
                        padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                        child: Center(
                          child: Text(
                            "Create",
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 188.0),
              ],
            ),
          ),
        ));
  }
}
