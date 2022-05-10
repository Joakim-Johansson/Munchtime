import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:flutter/material.dart';

///Screen where users can edit their bio
///
///Is accessed through Profile
class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  ProfileEditWidget createState() => ProfileEditWidget();
}

class ProfileEditWidget extends State<ProfileEdit> {
  late final TextEditingController controller;
  late String bio = "";

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: bio);
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
            "Edit",
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
                  image: AssetImage("assets/images/hills2.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 12, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'About me:\n',
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
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(AuthService().auth.currentUser!.uid)
                          .get(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          controller.text = snapshot.data!["bio"];

                          return TextField(
                            controller: controller,
                            maxLines: 15,
                            maxLength: 255,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 27, 67, 50),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () async {
                        bio = controller.text;
                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(AuthService().auth.currentUser!.uid)
                            .set({"bio": bio}, SetOptions(merge: true));
                        setState(() {});

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
                        padding: const EdgeInsets.fromLTRB(10, 6, 10, 4),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
