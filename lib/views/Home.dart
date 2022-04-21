import 'package:crunchtime/views/CreateGroup.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:crunchtime/views/CreateGroup.dart';
import 'package:crunchtime/views/JoinGroup.dart';
import 'package:crunchtime/views/Login.dart';
import 'package:crunchtime/views/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email'
    ]
);

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
  
}

class _HomeState extends State<Home> {
  GoogleSignInAccount? _currentUser;
  

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account){
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
              padding: const EdgeInsets.all(10.0),
              child: _buildWidget(),
                ),
              Row(
                children: [ Padding(
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
                  padding: const EdgeInsets.fromLTRB(22, 6, 22, 6),
                  child: Text("Join Group",
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
                MaterialPageRoute(builder: (context) => CreateGroup()),
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
                  child: Text("+",
                  style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontSize: 30,
                      ),),
                ),
                
                ),
                  )
                  ]
              ),
              ],
      ),
    ), 
     
    
    );
  }
  Widget _buildWidget() {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = FirebaseAuth.instance.currentUser;

    if(user == null){
        return Padding(
        padding: const EdgeInsets.all(0),
        child: TextButton.icon(
        onPressed: SignIn,
      // Respond to button press
        
        style: ButtonStyle(
          
          
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        
        RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(
              color: Color.fromARGB(255, 27, 67, 50))
            ),
            ),
        ),
        icon: const FaIcon(FontAwesomeIcons.google, color: Color.fromARGB(255, 82, 183, 136)), 
        label: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 22, 6),
          child: Text("Sign In",
            style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: 30,
                ),),
        ),
        
        ),
          );
          }
    else{
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: TextButton.icon(
            onPressed: () {Navigator.push(
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
                  color: Color.fromARGB(255, 27, 67, 50))
                ),
                ),
            ),
            icon: const FaIcon(FontAwesomeIcons.google, color: Color.fromARGB(255, 82, 183, 136)), 
            label: Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 22, 6),
              child: Text("Profile",
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
                onPressed: signOut,
                          // Respond to button pres
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
                  child: Text("Sign Out",
                  style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontSize: 30,
                      ),),
                ),
                
                ),
                  )
        ],
      );
          

    }
  
}
void SignIn() async {
    try{
      await _googleSignIn.signIn();
      await AuthService().signInWithGoogle();
    } catch(e){
      print('sign in error $e');
    }
  }

void signOut(){
    _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    
  }
}
  