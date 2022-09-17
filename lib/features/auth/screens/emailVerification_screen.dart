import 'dart:async';
import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = '/email-verification';
  final String email;
  final String pass;
  const VerificationScreen({Key? key, required this.email, required this.pass}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState(email, pass);
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
  final String pass;
  final AuthService authService = AuthService();
  static const maxSeconds = 60;
  static int seconds = maxSeconds;
  Timer? timer;
  bool status = true;
  bool buttonStatus = false;
  bool enterPage = true;

  // ignore: non_constant_identifier_names
  void StartTimer() {
    // ignore: prefer_const_constructors
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
          buttonStatus = !buttonStatus;
          status = false;
          setState(() {
            _o1letterController.text = "";
            _s2letterController.text = "";
            _t3letterController.text = "";
            _f4letterController.text = "";
            _fv5letterController.text = "";
            _st6letterController.text = "";
          });

          // verificationTimedOut();
        }
        //stopTimer();
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  // ignore: non_constant_identifier_names
  Widget clock() {
    if (seconds == 0) {
      setState(() {
        buttonStatus = true;
      });

      return const Text("OTP code is expired");
    }

    return Text("OTP code is going to expire in $seconds");
  }

  void deleteOTP() {
    authService.deleteOTP(context: context, email: email);
  }

  _VerificationScreenState(this.email, this.pass);

  @override
  void dispose() {
    super.dispose();
    _verificationController.dispose();
  }

  void verify() {
    String d6Number = _o1letterController.text +
        _s2letterController.text +
        _t3letterController.text +
        _f4letterController.text +
        _fv5letterController.text +
        _st6letterController.text;

    authService.verified(context: context, email: email, D6_number: d6Number, pass: pass);
  }

  void resendOTP() {
    authService.resendOTP(context: context, email: email);
    setState(() {
      seconds = maxSeconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    final serverStatus = Provider.of<AuthService>(context, listen: true);

    if (enterPage) {
      serverStatus.resendOTP(context: context, email: email);
    }

    setState(() {
      enterPage = false;
    });

    if (serverStatus.ServerStatus) {
      stopTimer();
      StartTimer();
    }

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
                    const Text("Enter your OTP code"),
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
                                  {
                                    FocusScope.of(context).nextFocus(),
                                    if (value.isEmpty)
                                      {FocusScope.of(context).previousFocus()}
                                  }
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _o1letterController,
                              enabled: status,
                            )),
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1)
                                  {FocusScope.of(context).nextFocus()},
                                if (value.isEmpty)
                                  {FocusScope.of(context).previousFocus()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _s2letterController,
                              enabled: status,
                            )),
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1)
                                  {FocusScope.of(context).nextFocus()},
                                if (value.isEmpty)
                                  {FocusScope.of(context).previousFocus()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _t3letterController,
                              enabled: status,
                            )),
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1)
                                  {FocusScope.of(context).nextFocus()},
                                if (value.isEmpty)
                                  {FocusScope.of(context).previousFocus()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _f4letterController,
                              enabled: status,
                            )),
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1)
                                  {FocusScope.of(context).nextFocus()},
                                if (value.isEmpty)
                                  {FocusScope.of(context).previousFocus()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _fv5letterController,
                              enabled: status,
                            )),
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              onChanged: (value) => {
                                if (value.length == 1) {verify()},
                                if (value.isEmpty)
                                  {FocusScope.of(context).previousFocus()}
                              },
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _st6letterController,
                              enabled: status,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buttonStatus == true
                        ? CustomButton(
                            text: "Resend OTP",
                            onTap: () async {
                              if (buttonStatus == true) {
                                setState(() {
                                  status = true;
                                  buttonStatus = false;
                                  _o1letterController.text = "";
                                  _s2letterController.text = "";
                                  _t3letterController.text = "";
                                  _f4letterController.text = "";
                                  _fv5letterController.text = "";
                                  _st6letterController.text = "";
                                });

                                deleteOTP();
                                resendOTP();
                              } else {
                                showToast(
                                    "Please wait until OTP to be timed out");
                              }
                            },
                          )
                        : const SizedBox(
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
