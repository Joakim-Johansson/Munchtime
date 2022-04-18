// import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/hills2.png"),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(
                  height: 15,
                ),
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
                      return Row(children: [
                        Flexible(
                          child: TextField(
                              controller: e,
                              decoration: const InputDecoration(
                                hintText: "Next Step",
                              )),
                        ),
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

  Row createRow(List<Object> e) {
    return Row(children: [
      Flexible(
        child: TextField(
            controller: e.first as TextEditingController,
            decoration: const InputDecoration.collapsed(
              hintText: "Next Step",
            )),
      ),
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
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (Object? value) => {
                setState(() {
                  e.last = value!;
                })
              }),
      IconButton(
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

    JsonRecipe completeRecipe = JsonRecipe(
      titleController.text,
      "yes",
      /*descriptionController.text,*/
      ingredientList,
      amountList, /*instructionList*/
    );

    http.Response response = await http.post(
        Uri.parse("https://cohesive-photon-346611.ew.r.appspot.com/recipes"),
        body: json.encode(completeRecipe));

    var checkit = json.encode(completeRecipe);
    response.statusCode;
  }
}
