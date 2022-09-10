import 'dart:async';
import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = '/email-verification';
  final String email;
  const VerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState(email);
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _verificationFormKey = GlobalKey<FormState>();
  final TextEditingController _verificationController = TextEditingController();
  final TextEditingController _o1letterController = TextEditingController();
  final TextEditingController _s2letterController = TextEditingController();
  final TextEditingController _t3letterController = TextEditingController();
  final TextEditingController _f4letterController = TextEditingController();
  final TextEditingController _fv5letterController = TextEditingController();
  final TextEditingController _st6letterController = TextEditingController();
  final String email;
  final AuthService authService = AuthService();
  static const maxSeconds = 5;
  static int seconds = maxSeconds;
  Timer? timer;

  // ignore: non_constant_identifier_names
  void StartTimer() {
    // ignore: prefer_const_constructors
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
          verificationTimedOut();
        }

        stopTimer();
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  // ignore: non_constant_identifier_names
  Widget clock() {
    if (seconds == 0) {
      return const Text("Verification code is expired");
    }

    return Text("Verification code is going to expire in $seconds");
  }

  void verificationTimedOut() async {
    authService.VerificationTimedout(context: context, email: email);
  }

  _VerificationScreenState(this.email);

  @override
  void dispose() {
    super.dispose();
    _verificationController.dispose();
  }

  void verify() {
    final String d6Number = _o1letterController.text +
        _s2letterController.text +
        _t3letterController.text +
        _f4letterController.text +
        _fv5letterController.text +
        _st6letterController.text;

    authService.verified(context: context, email: email, D6_number: d6Number);
  }

  @override
  Widget build(BuildContext context) {
    //stopTimer();
    StartTimer();

    return Scaffold(
      backgroundColor: globalV.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const SizedBox(
            height: 45,
          ),
          Container(
              padding: const EdgeInsets.all(12.0),
              color: globalV.backgroundColor,
              child: Form(
                key: _verificationFormKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    clock(),
                    const SizedBox(
                      height: 45,
                    ),
                    const Text("Enter your verification code"),
                    const SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1)
                                  {FocusScope.of(context).nextFocus()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _o1letterController,
                            )),
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1)
                                  {FocusScope.of(context).nextFocus()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _s2letterController,
                            )),
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1)
                                  {FocusScope.of(context).nextFocus()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _t3letterController,
                            )),
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1)
                                  {FocusScope.of(context).nextFocus()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _f4letterController,
                            )),
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1)
                                  {FocusScope.of(context).nextFocus()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _fv5letterController,
                            )),
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1)
                                  {FocusScope.of(context).nextFocus(), verify()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _st6letterController,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )),
        ]),
      )),
    );
  }
}
