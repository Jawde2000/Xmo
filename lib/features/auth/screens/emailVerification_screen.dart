import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = '/email-verification';
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final verificationFormKey = GlobalKey<FormState>();
  final TextEditingController _verificationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _verificationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalV.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
            child: const Text("Enter your verification number"),
            padding: const EdgeInsets.all(8.0),
            color: globalV.backgroundColor,
            
          ),
        ]),
      )),
    );
  }
}
