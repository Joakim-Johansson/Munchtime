import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:crunchtime/jsonRecipe.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({Key? key}) : super(key: key);

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

  ///Builds the form widget for creating recipes
  ///
  ///Contains several textfields for all info for recipes
  @override
  Widget build(BuildContext context) {
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
                const SizedBox(
                  height: 15,
                ),

                ///Title entry
                TextField(
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

    Response response = await dio
        .post("https://cohesive-photon-346611.ew.r.appspot.com/recipes", data: {
      "name": titleController.text,
      "user": "Hej",
      "ingredients": ingredientList,
      "amount": amountList
    });
  }
}
