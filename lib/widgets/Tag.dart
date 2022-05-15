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
            padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
            child: Text(tagName,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic),
                  ),),
          
          decoration: BoxDecoration(
            boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 2,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
            color: color,
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
