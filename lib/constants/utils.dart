import 'package:ximo/constants/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: const Duration(seconds: 2),
  ));
}

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: globalV.ximoColor,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #e19900, #e19900)",
      fontSize: 16.0);
}

// ignore: non_constant_identifier_names
// Widget showLoadingStatus(String status, bool Status) {
//   if (Status) {
//     EasyLoading.init();
//     EasyLoading.show(status: status);
//   }

//   return const SizedBox.shrink();
// }

// ignore: non_constant_identifier_names
Widget showLoadingStatus(bool Status) {
  if (Status) {
    // return const SpinKitCircle(size: 150, color: globalV.amazonColor,);
    return const Center(
      child: SpinKitCircle(
        size: 100,
        color: globalV.ximoColor,
      ),
    );
  }

  return const SizedBox.shrink();
}
