import 'package:crunchtime/views/JoinGroup.dart';
import 'package:crunchtime/views/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/hills3.png"),
            fit: BoxFit.cover)
            ),
      
      child: Column(
        crossAxisAlignment : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Welcome to Munch!',style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontFamily: 'Pattaya',
                  fontSize: 80,
                 ),
                 ),
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
              onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
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
              child: 
                Padding(
                padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
                child: Text("User Profile",
                style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: 30,
                    ),),
              ),
              ),
                ),
              Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
              child: TextButton(
              onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JoinGroup()),
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
                padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
                child: Text("Join a Group",
                style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: 30,
                    ),),
              ),
              ),
                )
              ],
      ),
    ),  
    
    );
  }
}