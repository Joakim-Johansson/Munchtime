import 'package:flutter/material.dart';
import 'package:crunchtime/views/ProfileEdit.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Profile extends StatelessWidget {
  final FirebaseUser user = await auth.currentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text("Profile",
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(22, 22, 22, 2),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/Will_Smith.jpg'), //GoogleUserCircleAvatar(identity: user)
              radius: 125,
              ),
          ),
          const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text("William Smed", //user.displayName ?? ''
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 67, 50),
                  fontSize: 30,
                ),
                ),
              ),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 12, 4),
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(text: const TextSpan(
                children: <TextSpan>[
                    TextSpan(
                      text: 'About me:\n', 
                      style: TextStyle(
                        color: Color.fromARGB(255, 27, 67, 50),
                        fontSize: 18,
                        fontWeight: FontWeight.bold, 
                        )
                      ),
                    TextSpan(
                      text: "Hi! I'm William and I just love food that has that little extra punch!", 
                      style: TextStyle(
                      color: Color.fromARGB(255, 27, 67, 50),
                      fontSize: 18,
                      ),
                    )
                    
                  ],
                  ),
                ),   
              )
              ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEdit()),
              );
                      // Respond to button press
              },
              style: ButtonStyle(
                
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              
              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 27, 67, 50))
                  ),
                  ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                child: Text("Edit bio",
                style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: 14,
                    ),),
                ),
              ),
            ),
          ),
          
        ],
        ),
      )

    );
}
}

//add sign out buttonStyle
// void signOut(){
//   _googleSignIn.disconnect();
// }