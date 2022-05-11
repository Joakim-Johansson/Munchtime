import 'dart:io';
import 'package:crunchtime/data/storage.dart';
import 'package:crunchtime/provider/auth.dart';
import 'package:dio/dio.dart';
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

  int portions = 2;

  ///Builds the form widget for creating recipes
  ///
  ///Contains several textfields for all info for recipes

  @override
  Widget build(BuildContext context) {
    if (widget.recipe != null) {
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
            return Container(
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
    }
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
                    Text(
                      "Add a photo",
                      style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontSize: 23,
                      ),
                    ),
                    IconButton(
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
                        setState(() {
                          image = File(tempImage.path);
                          displayedImage = Container(
                              child: image == null
                                  ? Container()
                                  : Image.file(File(image.path)));
                        });
                      },
                      icon: Icon(Icons.add, size: 30),
                    )
                  ],
                ),
                displayedImage,
                const SizedBox(
                  height: 15,
                ),

                ///Title entry
                TextField(
                    readOnly: edit,
                    controller: titleController,
                    decoration: InputDecoration(
                      fillColor: const Color(0xffc8e6c9),
                      filled: true, // dont forget this line

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(width: 3, color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(width: 3, color: Colors.green),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(width: 3, color: Colors.green),
                      ),

                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(width: 3, color: Colors.black),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.all(20.0),
                      labelText: "Recipe name",
                      labelStyle:
                          const TextStyle(fontSize: 34, color: Colors.black),
                    )),
                const SizedBox(
                  height: 15,
                ),

                ///Description
                TextField(
                    maxLength: null,
                    maxLines: null,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      fillColor: const Color(0xffc8e6c9),

                      filled: true, // dont forget this line

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(width: 3, color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(width: 3, color: Colors.green),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(width: 3, color: Colors.green),
                      ),

                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(width: 3, color: Colors.black),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.all(20.0),
                      labelText: "Description",
                      labelStyle:
                          const TextStyle(fontSize: 34, color: Colors.black),
                    )),

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
                      border: Border.all(color: Colors.green, width: 4)),
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Add ingredient"),
                        Icon(Icons.add),
                      ]),
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
                      border: Border.all(color: Colors.green, width: 4)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: instructionControllers.map((e) {
                      return Column(children: [
                        Row(children: [
                          Flexible(
                            child: TextField(
                                controller: e,
                                decoration: const InputDecoration.collapsed(
                                  hintText: "Next Step",
                                )),
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Add instruction"),
                        Icon(Icons.add),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
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
                TextButton(
                  onPressed: sendRecipe,
                  child: const Text('Done'),
                )
              ]),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            title: Text("Create recipe",
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
        child: TextField(

            ///First is the TextEditingController
            controller: e.first as TextEditingController,
            decoration: const InputDecoration.collapsed(
              hintText: "Next Ingredient",
            )),
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
                title: Text("Something is missing"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Continue"))
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
    }

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Recipe Created!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        jumpToRecipeList(context);
                      },
                      child: Text("Great!"))
                ],
              ));
    } else {
      AlertDialog(title: Text("Recipe failed creation"));
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
