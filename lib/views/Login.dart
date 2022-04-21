import 'package:flutter/material.dart';
import 'package:crunchtime/views/ProfileEdit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

// import '../provider/google_sign_in.dart';
import '../widgets/Sign_In_Widget.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text("Login",
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
            image: AssetImage("assets/images/hills2.png"),
            fit: BoxFit.cover)
            ),
        child: Column(
          children: [
            Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
            child: Text('Welcome to Munch!',style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontFamily: 'Pattaya',
                  fontSize: 40,
                 ),
                 ),
          ),
            const Align(
              child: Sign_In_Widget()
            )
          ],
        )
      )

    );
}
}

