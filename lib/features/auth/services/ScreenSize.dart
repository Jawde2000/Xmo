// ignore: file_names
import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class screenSize {
  double returnScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double returnScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
