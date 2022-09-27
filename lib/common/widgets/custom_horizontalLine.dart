// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HorizontalLine extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final Color colour;

  const HorizontalLine({
    Key? key,
    required this.label,
    required this.height,
    required this.width,
    required this.colour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: colour,
              height: height,
            )),
      ),
      Text(label),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: colour,
              height: height,
            )),
      ),
    ]);
  }
}
