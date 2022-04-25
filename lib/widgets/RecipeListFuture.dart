import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crunchtime/views/RecipeCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeListFuture extends StatelessWidget {
  late String command;

  RecipeListFuture(this.command);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
        future: http.get(Uri.parse(
            "https://cohesive-photon-346611.ew.r.appspot.com/search/" +
                command)),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.statusCode == 200) {
              var recipes = json.decode(snapshot.data!.body);
              return GridView.count(
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  crossAxisCount: 1,
                  padding: EdgeInsets.all(10),
                  children: recipes.map<Widget>((e) => RecipeCard(e)).toList());
            }
            return Text("No Results");
          }
          return Text("Waiting");
        });
  }
}
