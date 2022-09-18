import 'package:amazon/common/widgets/custom_navbar.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AmazonScreen extends StatefulWidget {
  static const String routeName = "/amazon";
  const AmazonScreen({Key? key}) : super(key: key);

  @override
  State<AmazonScreen> createState() => _AmazonScreenState();
}

class _AmazonScreenState extends State<AmazonScreen> {
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
