import 'package:ximo/common/widgets/custom_navbar.dart';
import 'package:ximo/constants/global_variables.dart';
import 'package:flutter/material.dart';

class XmoScreen extends StatefulWidget {
  static const String routeName = "/xmo";
  const XmoScreen({Key? key}) : super(key: key);

  @override
  State<XmoScreen> createState() => _XmoScreenState();
}

class _XmoScreenState extends State<XmoScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: globalV.backgroundColor,
      body: const SafeArea(
        child: NavBar(),
      ),
    );
  }
}
