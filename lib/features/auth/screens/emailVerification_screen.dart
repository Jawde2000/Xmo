import 'dart:async';
import 'package:ximo/common/widgets/custom_button.dart';
import 'package:ximo/constants/global_variables.dart';
import 'package:ximo/constants/utils.dart';
import 'package:ximo/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = '/email-verification';
  final String email;
  final String pass;
  final String name;
  const VerificationScreen(
      {Key? key, required this.email, required this.pass, required this.name})
      : super(key: key);

  @override
  State<VerificationScreen> createState() =>
      _VerificationScreenState(this.email, this.pass, this.name);
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _verificationFormKey = GlobalKey<FormState>();
  final TextEditingController _o1letterController = TextEditingController();
  final TextEditingController _s2letterController = TextEditingController();
  final TextEditingController _t3letterController = TextEditingController();
  final TextEditingController _f4letterController = TextEditingController();
  final TextEditingController _fv5letterController = TextEditingController();
  final TextEditingController _st6letterController = TextEditingController();
  final String email;
  final String pass;
  final String name;
  final AuthService authService = AuthService();
  static const maxSeconds = 10;
  static int seconds = maxSeconds;
  Timer? timer;
  bool status = true;
  bool buttonStatus = false;
  bool enterPage = true;
  bool lastNum = true;

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
          status = false;
          buttonStatus = !buttonStatus;
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

  _VerificationScreenState(this.email, this.pass, this.name);

  @override
  void dispose() {
    super.dispose();
    _o1letterController.dispose();
    _s2letterController.dispose();
    _t3letterController.dispose();
    _f4letterController.dispose();
    _fv5letterController.dispose();
    _st6letterController.dispose();
  }

  void verify() {
    print("emailVerification-verifyVoid passed");
    String d6Number = _o1letterController.text +
        _s2letterController.text +
        _t3letterController.text +
        _f4letterController.text +
        _fv5letterController.text +
        _st6letterController.text;

    authService.loginVerified(
        context: context,
        email: email,
        D6_number: d6Number,
        pass: pass,
        name: name);
  }

  void resendOTP() {
    // ignore: non_constant_identifier_names
    final Status = Provider.of<AuthService>(context, listen: false);
    Status.resendOTP(context: context, email: email, name: name);
    if (Status.ServerStatus) {
      setState(() {
        seconds = maxSeconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Status = Provider.of<AuthService>(context, listen: true);

    if (enterPage) {
      resendOTP();
    }

    setState(() {
      enterPage = false;
    });

    if (Status.ServerStatus) {
      stopTimer();
      StartTimer();
    }

    return Scaffold(
      backgroundColor: globalV.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
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
                                  {
                                    FocusScope.of(context).nextFocus(),
                                  },
                                if (value.isEmpty)
                                  {
                                    FocusScope.of(context).previousFocus(),
                                  }
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
                                  {
                                    FocusScope.of(context).nextFocus(),
                                  },
                                if (value.isEmpty)
                                  {
                                    FocusScope.of(context).previousFocus(),
                                  }
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
                                  {
                                    FocusScope.of(context).nextFocus(),
                                  },
                                if (value.isEmpty)
                                  {
                                    FocusScope.of(context).previousFocus(),
                                  }
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
                                  {
                                    FocusScope.of(context).nextFocus(),
                                  },
                                if (value.isEmpty)
                                  {
                                    FocusScope.of(context).previousFocus(),
                                  }
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
                                if (value.length == 1)
                                  {
                                    verify(),
                                    setState(() {
                                      status = !status;
                                    }),
                                  },
                                if (value.isEmpty)
                                  {
                                    FocusScope.of(context).previousFocus(),
                                  }
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
                            text: const Text(
                              "Resend OTP",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () async {
                              if (buttonStatus == true) {
                                deleteOTP();
                                setState(() {
                                  status = true;
                                  buttonStatus = !buttonStatus;
                                  _o1letterController.text = "";
                                  _s2letterController.text = "";
                                  _t3letterController.text = "";
                                  _f4letterController.text = "";
                                  _fv5letterController.text = "";
                                  _st6letterController.text = "";
                                });
                                resendOTP();
                              } else {
                                showToast(
                                  "Please wait until OTP to be timed out",
                                );
                              }
                            },
                            height: 0.08,
                            width: 0.3,
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
