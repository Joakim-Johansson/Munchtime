import 'package:flutter/material.dart';
import 'GroupCard.dart';

class Groups extends StatelessWidget {
  final List<GroupCard> dummyList = List.filled(3, const GroupCard());

  Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "Groups",
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontFamily: 'Pattaya',
              fontSize: 30,
            ),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          elevation: 0,
        ),
        body: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 3 / 1,
          children: dummyList,
        ));
  }
}
