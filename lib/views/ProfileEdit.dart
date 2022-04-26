import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  ProfileEditWidget createState() => ProfileEditWidget();
}

class ProfileEditWidget extends State<ProfileEdit> {
  late final TextEditingController controller;
  String bio = "";

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
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
void getData()async{ //use a Async-await function to get the data
    final data =  await FirebaseFirestore.instance.collection("listofprods").get(bio) ; //get the data
     DocumentSnapshot snapshot = data;
  }
  Future<void> changeBio() {
      // Call the user's CollectionReference to add a new user

      return users
          .add({
            'bio': bio, // John Doe// 42
          })
          .then((value) => print("Bio changed"))
          .catchError((error) => print("Failed to change bio"));
    }
  
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
                child: TextField(
                  controller: controller,
                  maxLines: 15,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 27, 67, 50),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        bio = controller.text;
                      });
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
        ));
  }
}
