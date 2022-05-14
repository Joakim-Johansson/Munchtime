import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  String tagName;
  Color color;
  Tag(this.tagName, this.color);

  ///Builds a tag
  ///
  ///Generic information blob
  ///Can display any string with a choice of colored background
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
