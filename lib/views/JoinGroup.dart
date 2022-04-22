import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:flutter/material.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({Key? key}) : super(key: key);

  @override
  JoinGroupWidget createState() => JoinGroupWidget();
}

class JoinGroupWidget extends State<JoinGroup> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: 'hej');
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
            "Join Group",
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
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/blob2.png"),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Enter the 6-letter Invite Code:\n',
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
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: controller,
                  maxLines: 1,
                  maxLength: 6,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 80, 6),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () async {
                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection('groups')
                          .where("code", isEqualTo: controller.text)
                          .get();

                      if (snap.docs.isNotEmpty) {
                        print("exits");

                        await FirebaseFirestore.instance
                          .collection('Users').doc(AuthService().auth.currentUser?.uid).
                          set({"groups": FieldValue.arrayUnion([controller.text])}, SetOptions(merge: true));
                      } else {
                        print("Doc doesn't exits");
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          "Join",
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
              const SizedBox(height: 188.0),
            ],
          ),
        ));
  }
}
