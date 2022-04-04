import 'package:flutter/material.dart';

class CreateRecipe extends StatefulWidget {
  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  TextEditingController TitleController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  List<TextEditingController> IngredientControllers = [TextEditingController()];
  List<TextEditingController> InstructionControllers = [
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
                    controller: TitleController,
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
                    controller: DescriptionController,
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
                    children: IngredientControllers.map((e) {
                      return Row(children: [
                        Flexible(
                          child: TextField(
                              controller: e,
                              decoration: const InputDecoration(
                                hintText: "Next Step",
                              )),
                        ),
                        IconButton(
                            onPressed: IngredientControllers.length != 1
                                ? () => setState(() {
                                      IngredientControllers.remove(e);
                                    })
                                : () {},
                            icon: IngredientControllers.length == 1
                                ? Icon(
                                    Icons.abc,
                                    size: 0.0,
                                  )
                                : Icon(Icons.remove))
                      ]);
                    }).toList(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      IngredientControllers.add(TextEditingController());
                    });
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Add ingredient"),
                        const Icon(Icons.add),
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
                    children: InstructionControllers.map((e) {
                      return Row(children: [
                        Flexible(
                          child: TextField(
                              controller: e,
                              decoration: const InputDecoration(
                                hintText: "Next Step",
                              )),
                        ),
                        IconButton(
                            onPressed: InstructionControllers.length != 1
                                ? () => setState(() {
                                      InstructionControllers.remove(e);
                                    })
                                : () {},
                            icon: InstructionControllers.length == 1
                                ? Icon(
                                    Icons.abc,
                                    size: 0.0,
                                  )
                                : Icon(Icons.remove))
                      ]);
                    }).toList(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      InstructionControllers.add(TextEditingController());
                    });
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Add instruction"),
                        const Icon(Icons.add),
                      ]),
                ),
                TextButton(
                  onPressed: () {},
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
}
