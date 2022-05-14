import 'dart:io';
import 'package:crunchtime/data/storage.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateRecipe extends StatefulWidget {
  Storage storage = Storage();
  var recipe;

  CreateRecipe([this.recipe]);

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<List<Object>> ingredientControllers = [
    [TextEditingController(), "100g"]
  ];
  List<TextEditingController> instructionControllers = [
    TextEditingController()
  ];
  String fileName = '';
  var image;

  Widget displayedImage = Container();
  bool edit = false;
  bool firstTimeSet = false;
  int portions = 2;
  String pageType = "";
  bool image_exist = false;

  ///Builds the form widget for creating recipes
  ///
  ///Contains several textfields for all info for recipes

  @override
  Widget build(BuildContext context) {
    if (widget.recipe != null && !firstTimeSet) {
      Map<String, dynamic> recipe = widget.recipe;
      titleController.text = recipe["name"];
      descriptionController.text = recipe["description"];
      ingredientControllers[0] = extractIngredients(recipe["ingredients"][0]);
      for (int i = 1; i < recipe["ingredients"].length; i++) {
        ingredientControllers.add(extractIngredients(recipe["ingredients"][i]));
      }
      instructionControllers[0].text = recipe["instructions"][0];
      for (int i = 1; i < recipe["instructions"].length; i++) {
        instructionControllers
            .add(TextEditingController(text: recipe["instructions"][i]));
      }
      portions = recipe["portions"];
      edit = true;

      displayedImage = FutureBuilder(
        future: widget.storage.downloadURL(widget.recipe["img"]),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 400,
              width: 400,
              child: Image.network(
                snapshot.data!,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container();
          }
        },
      );
      fileName = recipe["img"];
      pageType = "Edit Recipe";
    } else if (!firstTimeSet) {
      pageType = "Create Recipe";
    }
    firstTimeSet = true;
    return Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(

                  ///Background image
                  image: AssetImage("assets/images/hills2.png"),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 4), // changes position of shadow
                              ),
                            ],
                            color: Color.fromARGB(255, 149, 213, 178),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: IconButton(
                          onPressed: () async {
                            final tempImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (tempImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("No file selected")));

                              return;
                            }

                            final path = tempImage.path;
                            fileName = tempImage.name;

                            widget.storage
                                .uploadFile(path, fileName)
                                .then((value) => print("done"));
                            image_exist = true;
                            setState(() {
                              image = File(tempImage.path);
                              displayedImage = Container(
                                  child: image == null
                                      ? Container()
                                      : Image.file(File(image.path)));
                            });
                          },
                          icon: const Icon(Icons.add_a_photo, size: 30),
                        ),
                      ),
                    )
                  ],
                ),

                ShowImage(
                    displayedImage: displayedImage, imageExists: image_exist),
                const SizedBox(
                  height: 15,
                ),

                ///Title entry
                const Align(
                  alignment: Alignment(-0.81, 0),
                  child: Text(
                    "Name",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                            color: Color.fromARGB(255, 116, 198, 157),
                            width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                              readOnly: edit,
                              controller: titleController,
                              decoration: const InputDecoration.collapsed(
                                hintText: "Name your recipe",
                              )),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),

                ///Description
                const Align(
                  alignment: Alignment(-0.81, 0),
                  child: Text(
                    "Description",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                              color: Color.fromARGB(255, 116, 198, 157),
                              width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                                controller: descriptionController,
                                decoration: const InputDecoration.collapsed(
                                  hintText: "Describe your recipe",
                                )),
                          ],
                        ),
                      )),
                ),

                ///Ingredients
                const Align(
                  alignment: Alignment(-0.81, 0),
                  child: Text(
                    "Ingredients",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 116, 198, 157), width: 2)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: ingredientControllers.map((e) {
                      return Column(children: [
                        createRow(e),

                        ///Set [divider] unless last item
                        ingredientControllers.last == e
                            ? Container()
                            : const Divider(
                                thickness: 2,
                              )
                      ]);
                    }).toList(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      ingredientControllers
                          .add([TextEditingController(), "100g"]);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 160,
                      height: 35,
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 183, 228, 199),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(1, 4), // changes position of shadow
                          ),
                        ], // ignore: prefer_const_constructors
                      ),

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Add ingredient"),
                            Icon(Icons.add),
                          ]),
                    ),
                  ),
                ),

                ///Instructions
                const Align(
                  alignment: Alignment(-0.81, 0),
                  child: Text(
                    "Instructions",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 116, 198, 157), width: 2)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: instructionControllers.map((e) {
                      return Column(children: [
                        Row(children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                  controller: e,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: "Next Step",
                                  )),
                            ),
                          ),

                          ///Write a minus icon if the user has added extra steps
                          IconButton(
                              onPressed: instructionControllers.length != 1
                                  ? () => setState(() {
                                        instructionControllers.remove(e);
                                      })
                                  : () {},
                              icon: instructionControllers.length == 1
                                  ? const Icon(
                                      Icons.abc,
                                      size: 0.0,
                                    )
                                  : const Icon(Icons.remove))
                        ]),
                        instructionControllers.last == e
                            ? Container()
                            : const Divider(
                                thickness: 2,
                              ),
                      ]);
                    }).toList(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      instructionControllers.add(TextEditingController());
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 160,
                      height: 35,
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 183, 228, 199),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(1, 4), // changes position of shadow
                          ),
                        ], // ignore: prefer_const_constructors
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Add instruction"),
                            Icon(Icons.add),
                          ]),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text("Portions:"),
                ),
                NumberPicker(
                  axis: Axis.horizontal,
                  value: portions,
                  maxValue: 20,
                  minValue: 1,
                  step: 1,
                  onChanged: (value) => setState(() => portions = value),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 6), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                    child: TextButton(
                      onPressed: sendRecipe,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(100, 116, 198, 157)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 6, 22, 6),
                        child: Text(
                          "Create recipe",
                          style: TextStyle(
                            color: Color.fromARGB(255, 8, 28, 21),
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            title: Text(pageType,
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontFamily: 'Pattaya',
                  fontSize: 30,
                ))));
  }

  ///Creates a row containing all Objects for ingredients
  ///
  ///A row object containing a [TextEditingController] for an ingredient as well as
  ///a dropdown menu containing different choices for an amount of each ingredient.
  ///The function requires a list containing one [TextEditingController] and a
  ///[String] representing one of the dropdownvalues
  Row createRow(List<Object> e) {
    return Row(children: [
      Flexible(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(

              ///First is the TextEditingController
              controller: e.first as TextEditingController,
              decoration: const InputDecoration.collapsed(
                hintText: "Next Ingredient",
              )),
        ),
      ),

      ///Last is the String
      DropdownButton(
          value: e.last,
          items: [
            "10g",
            "15g",
            "25g",
            "50g",
            "75g",
            "100g",
            "200g",
            "300g",
            "400g",
            "500g",
            "600g",
            "700g",
            "800g",
            "900g",
            "1000g"
          ].map<DropdownMenuItem<String>>((String value) {
            ///Adds all the above values to the dropdownmenu
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),

          ///Changes the value when the user chooses a new one from the menu
          onChanged: (Object? value) => {
                setState(() {
                  e.last = value!;
                })
              }),
      IconButton(

          ///Logic for removal of an added item
          onPressed: ingredientControllers.length != 1
              ? () => setState(() {
                    ingredientControllers.remove(e);
                  })
              : () {},
          icon: ingredientControllers.length == 1
              ? const Icon(
                  Icons.abc,
                  size: 0.0,
                )
              : const Icon(Icons.remove)),
    ]);
  }

  ///Sends the entered information as a jsonobject to the api
  ///
  ///Asynchronus function as it has to wait for a response from the api
  ///Gathers the information entered in the form and translates it to
  ///Lists and strings which the api can interpret. In the case of a mistake
  ///on the users or system's part there is an exception check which will
  ///display an alert window showing an error message
  void sendRecipe() async {
    if (checkIfEmpty()) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("Something is missing"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Continue"))
                ],
              ));
      return;
    }
    List<String> ingredientList = [];
    List<int> amountList = [];
    List<String> instructionList = [];

    //Parses list of ingredient entries and amounts
    //Extracts info to seperate lists
    for (var i = 0; i < ingredientControllers.length; i++) {
      for (var p = 0; p < ingredientControllers[i].length; p++) {
        if (ingredientControllers[i][p] is TextEditingController) {
          var tempVar = ingredientControllers[i][p] as TextEditingController;
          ingredientList.add(tempVar.text);
        } else {
          var tempVar = ingredientControllers[i][p] as String;
          amountList.add(int.parse(tempVar.substring(0, tempVar.length - 1)));
        }
      }
    }

    for (var i = 0; i < instructionControllers.length; i++) {
      instructionList.add(instructionControllers[i].text);
    }

    Dio dio = Dio();
    Response response;

    if (!edit) {
      response = await dio.post(
          "https://cohesive-photon-346611.ew.r.appspot.com/recipes",
          data: {
            "name": titleController.text,
            "user": AuthService().auth.currentUser!.uid,
            "description": descriptionController.text,
            "instructions": instructionList,
            "ingredients": ingredientList,
            "amount": amountList,
            "img": fileName,
            "portions": portions
          });
    } else {
      response = await dio.put(
          "https://cohesive-photon-346611.ew.r.appspot.com/recipes",
          data: {
            "name": titleController.text,
            "user": AuthService().auth.currentUser!.uid,
            "description": descriptionController.text,
            "instructions": instructionList,
            "ingredients": ingredientList,
            "amount": amountList,
            "img": fileName,
            "portions": portions
          });
    }

    if (response.statusCode == 200 && !response.data.containsKey("Error")) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("Recipe Created!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        jumpToRecipeList(context);
                      },
                      child: const Text("Great!"))
                ],
              ));
    } else if (response.data.containsKey("Error")) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(title: Text(response.data["Error"])));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(title: Text("Recipe Failed Creation")));
    }
  }

  List<Object> extractIngredients(String values) {
    String amount = "";
    String name = "";
    bool switched = false;
    String substring = values.substring(1, values.length - 1);
    for (int i = 0; i < substring.length; i++) {
      if (switched) {
        name += substring[i];
      } else {
        amount += substring[i];
      }
      if (substring[i] == "g") {
        i += 2;
        switched = true;
      }
    }

    TextEditingController tempController = TextEditingController();
    tempController.text = name;

    return [tempController, amount];
  }

  void jumpToRecipeList(BuildContext widgetContext) {
    Navigator.of(widgetContext).pop();
    Navigator.pushNamed(context, "/recipelist");
  }

  bool checkIfEmpty() {
    List<bool> returnVal = List.filled(5, false);
    returnVal[0] = titleController.text == "";
    returnVal[1] = descriptionController.text == "";
    for (int i = 0; i < ingredientControllers.length && !returnVal[2]; i++) {
      TextEditingController temp =
          ingredientControllers[i][0] as TextEditingController;
      returnVal[2] = temp.text == "";
    }
    for (int i = 0; i < instructionControllers.length && !returnVal[3]; i++) {
      returnVal[3] = instructionControllers[i].text == "";
    }
    returnVal[4] = fileName == "";

    return returnVal[0] ||
        returnVal[1] ||
        returnVal[2] ||
        returnVal[3] ||
        returnVal[4];
  }
}

class ShowImage extends StatelessWidget {
  const ShowImage({
    Key? key,
    required this.displayedImage,
    required this.imageExists,
  }) : super(key: key);

  final Widget displayedImage;
  final bool imageExists;
  @override
  Widget build(BuildContext context) {
    if (imageExists) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(6, 6, 6, 10),
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
              border: Border.all(
                  color: Color.fromARGB(255, 149, 213, 178), width: 2),
            ),
            child: displayedImage),
      );
    } else {
      return Container();
    }
  }
}
