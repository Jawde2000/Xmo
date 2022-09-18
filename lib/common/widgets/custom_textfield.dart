import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLength;
  final RegExp regex;
  final String emptyText;
  final String regexText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.maxLength,
    required this.regex,
    required this.emptyText,
    required this.regexText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color.fromARGB(31, 68, 114, 196),
        )),
        // enabledBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(
        //   color: Colors.black12,
        // )),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return emptyText;
        } else {
          if (!regex.hasMatch(val)) {
            return regexText;
          }
        }

        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
    );
  }
}
