import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunchtime/data/storage.dart';
import 'package:crunchtime/views/CreateGroup.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:crunchtime/views/CreateGroup.dart';
import 'package:crunchtime/views/JoinGroup.dart';
import 'package:crunchtime/views/Login.dart';
import 'package:crunchtime/views/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

///First page that is loaded
///
///Contains buttons for login, group creating and joining groups
///Bottom bar leads to all other pages
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });

    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/hills3.png"),
                    fit: BoxFit.cover)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome to Munch!',
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontFamily: 'Pattaya',
                    fontSize: 80,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _buildWidget(context),
              ),
            ])));
  }

  Widget _buildWidget(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: TextButton.icon(
          onPressed: SignIn,
          // Respond to button press

          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side:
                      const BorderSide(color: Color.fromARGB(255, 27, 67, 50))),
            ),
          ),
          icon: const FaIcon(FontAwesomeIcons.google,
              color: Color.fromARGB(255, 82, 183, 136)),
          label: Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 22, 6),
            child: Text(
              "Sign In",
              style: TextStyle(
                color: Theme.of(context).focusColor,
                fontSize: 30,
              ),
            ),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                    // Respond to button press
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 27, 67, 50))),
                    ),
                  ),
                  icon: const FaIcon(FontAwesomeIcons.google,
                      color: Color.fromARGB(255, 82, 183, 136)),
                  label: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 22, 6),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
                child: TextButton(
                  onPressed: signOut,
                  // Respond to button pres
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 27, 67, 50))),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 8, 8),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const JoinGroup()),
                  );
                  // Respond to button press
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
                  padding: const EdgeInsets.fromLTRB(22, 6, 22, 6),
                  child: Text(
                    "Join Group",
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateGroup()),
                  );
                  // Respond to button press
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
                  padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
                  child: Text(
                    "+",
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ],
      );
    }
  }

  void SignIn() async {
    try {
      await _googleSignIn.signIn();
      await AuthService().signInWithGoogle();
      setState(() {});

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(AuthService().auth.currentUser?.uid)
          .set({
        "name": AuthService().auth.currentUser?.displayName,
        "photo": AuthService().auth.currentUser!.photoURL!,
        "bio": ""
      }, SetOptions(merge: true));

    } catch (e) {
      print('sign in error $e');
    }
  }

  void signOut() {
    _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
