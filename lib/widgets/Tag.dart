import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  String tagName;
  Color color;
  Tag(this.tagName, this.color);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 7, right: 7),
            child: Text(tagName),
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
