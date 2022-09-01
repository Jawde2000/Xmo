import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: globalV.amazonColor,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #e19900, #e19900)",
      fontSize: 16.0);
}

