import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipesState();
}

class _RecipesState extends State<RecipePage> {
  int rating = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 247),
      appBar: AppBar(
        title: const Text('Recipes',
            style: TextStyle(
              color: Color.fromARGB(255, 41, 56, 45),
              fontFamily: 'OpenSans',
              fontStyle: FontStyle.italic,
              fontSize: 26,
            )),
        centerTitle: true,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/carbonara.jpg'),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6.0),
              const Center(
                child: Text('Carbonara',
                    style: TextStyle(
                      color: Color.fromARGB(255, 49, 49, 49),
                      fontFamily: 'OpenSans',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 6.0),
              Center(
                child: Text(
                  'Delicious pasta with cheese and bacon. \nRating: $rating/5',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 49, 49, 49),
                    fontFamily: 'OpenSans',
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '10L',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'OpenSans',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const WidgetSpan(
                              child: Icon(
                                Icons.water_drop,
                                color: Color.fromARGB(255, 13, 75, 117),
                                size: 23.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(235, 3, 110, 211),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            const TextSpan(
                              text: '10kg ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'OpenSans',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const WidgetSpan(
                              child: const Icon(
                                Icons.co2_rounded,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: const Color.fromARGB(236, 44, 122, 5),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Med',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'OpenSans',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(235, 245, 188, 0),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              const Text('Ingredients:',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 49, 49, 49),
                    fontFamily: 'OpenSans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 6.0),
              const Text(
                ' - 600g Spaghetti \n - 20g Egg \n - 100g Parmiggiano Reggiano \n - 500g Pork \n - 10g Garlic \n - 300g Cream',
                style: TextStyle(
                  color: const Color.fromARGB(255, 49, 49, 49),
                  fontFamily: 'OpenSans',
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Recipe:',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 49, 49, 49),
                    fontFamily: 'OpenSans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  )),
              const SizedBox(height: 16.0),
              const Text(
                ' 1. Boil spaghetti according to package instructions \n 2. Fry bacon with garlic \n 3. Add cream & cheese then serve hot with pasta',
                style: const TextStyle(
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontFamily: 'OpenSans',
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
