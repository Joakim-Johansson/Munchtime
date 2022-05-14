import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../provider/auth.dart';

class Sign_In_Widget extends StatelessWidget {
  const Sign_In_Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 200,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 64, 145, 108),
            onPrimary: Color.fromARGB(255, 255, 255, 255)),
        icon: const FaIcon(FontAwesomeIcons.google,
            color: Color.fromARGB(255, 216, 243, 220)),
        label: const Text('Sign-in with google'),
        onPressed: () async {
          UserCredential user = await AuthService().signInWithGoogle();
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(AuthService().auth.currentUser?.uid)
              .set({
            "name": AuthService().auth.currentUser?.displayName,
            "bio": ""
          }, SetOptions(merge: true));
        },
      ),
    );
  }
}
