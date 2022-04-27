import 'package:crunchtime/views/JoinGroup.dart';
import 'package:flutter/material.dart';
import 'package:crunchtime/views/CreateGroup.dart';

class ManageGroups extends StatefulWidget{
  @override
  ManageGroupsWidget createState() => ManageGroupsWidget();

}

class ManageGroupsWidget extends State<ManageGroups>{

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar:AppBar(
        title:Text("Manage Groups",
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
            image: AssetImage("assets/images/hills3.png"),
            fit: BoxFit.cover)
          ),

      //Here goes the buttons for group management.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          //Insert a picture representing a group.
          Image(
            image: AssetImage('assets/images/groupImage.png'),
            width: 225.0,
            height: 175.0,
          ),

          //Button for creating groups.
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 10, 80, 6),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateGroup()),
                    );
                  }, 
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 27, 67, 50)
                          )
                      )
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                    child: Center(
                      child: Text("Create a Group",
                        style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize: 25,
                    ),
                    )
                  ),
                )
              )
            )
          ),
          ),

          SizedBox(height: 10.0),

          //Button for joining groups.
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 0, 80, 6),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JoinGroup()),
                  );
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
                  padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                  child: Center(
                    child: Text("Join a Group",
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
          SizedBox(height:188.0),

        ],
      ),

      )

    );
  }
}