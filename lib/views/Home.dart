import 'package:crunchtime/views/Profile.dart';
import 'package:crunchtime/views/ManageGroups.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
              child: Text('Welcome to Munch!',style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontFamily: 'Pattaya',
                    fontSize: 60,
                   ),
                   ),
            ),
          ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Image(
                  //Home page picture - can be changed if there is another preferred one.
                  image: AssetImage('assets/images/homePagePicture.png'),
                  width: 210.0,
                  height: 155.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextButton(
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
                child:
                  Padding(
                  padding: const EdgeInsets.fromLTRB(54, 6, 54, 6),
                  child: Text("View Profile",
                  style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontSize: 30,
                      ),),
                ),
                ),
              ),
                ),
          

          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
            child: Center(
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageGroups()),
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
                  padding: EdgeInsets.fromLTRB(24, 6, 24, 6),
                  child: Text("Manage Groups",
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
              ],

      ),
    ),  
    
    );
  }
}