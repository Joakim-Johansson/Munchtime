import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  @override
  ProfileEditWidget createState() => ProfileEditWidget();
  
}

class ProfileEditWidget extends State<ProfileEdit> {
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
          title: Text("Edit",
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
                  ],
                  ),
                ), 
              )
              ), 
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 12, 4),
            child: Container(

              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                style: const TextStyle(
                      color: Color.fromARGB(255, 27, 67, 50),
                      fontSize: 18,
                      fontWeight: FontWeight.bold, 
                      ),
                
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
              onPressed: () {
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
                child: Text("Save",
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
      )

    );
}
}