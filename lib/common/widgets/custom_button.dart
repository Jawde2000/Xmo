import "package:flutter/material.dart";

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final double height;
  final Text text;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double screenWidth = width * this.width;
    double height = MediaQuery.of(context).size.height;
    double screenHeight = height * this.height;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(screenWidth, screenHeight),
      ),
      child: text,
    );
  }
}
