import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crunchtime/views/RecipeCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeListFutureHorizontal extends StatelessWidget {
  late String command;

  RecipeListFutureHorizontal(this.command);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
        future: http.get(Uri.parse(
            "https://cohesive-photon-346611.ew.r.appspot.com/userrecipe/" +
                command)),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.statusCode == 200) {
              List<dynamic> recipes = json.decode(snapshot.data!.body);
              if (recipes.isNotEmpty) {
                return GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    crossAxisCount: 1,
                    padding: EdgeInsets.all(10),
                    children:
                        recipes.map<Widget>((e) => RecipeCard(e)).toList());
              }
              return const Center(
                  child: Text(
                "No Recipes Yet",
                style: TextStyle(fontSize: 40),
              ));
            }
            return const Text("No Results");
          }
          return Text("Waiting");
        });
  }
}
