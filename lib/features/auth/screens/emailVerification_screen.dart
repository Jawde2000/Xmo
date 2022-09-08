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
                    const Text("Enter your verification number"),
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
                                  {FocusScope.of(context).nextFocus(),
                                  verify()
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
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: "Submit",
                      onTap: (() {
                        verify();
                      }),
                    )
                  ],
                ),
              )),
        ]),
      )),
    );
  }
}
