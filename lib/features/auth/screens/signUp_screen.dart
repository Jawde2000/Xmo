import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_loadingIndicator.dart';
import '../../../common/widgets/custom_passwordtextfield.dart';

enum Auth {
  signup,
  signin,
}

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _repeatPassController = TextEditingController();
  final AuthService authService = AuthService();
  bool status = false;
  final double borderRadius = 12;

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _passController.dispose();
    _nameController.dispose();
  }

  void signup() {
    authService.signUp(
        context: context,
        email: _mailController.text,
        pass: _passController.text,
        name: _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    final overlay = LoadingOverlay.of(context);
    return Scaffold(
      backgroundColor: globalV.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Amazon",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w100,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: globalV.backgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
              ),
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _signupFormKey,
                child: Column(children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _nameController,
                    hintText: "Name",
                    maxLength: 50,
                    regex: RegExp(""),
                    emptyText: "Name field mandatory",
                    regexText: "",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _mailController,
                    hintText: "Email",
                    maxLength: 320,
                    regex: RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                    emptyText: "Email  field mandatory",
                    regexText: "Please enter a valid email",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordTextField(
                    controller: _passController,
                    hintText: "Password",
                    maxLength: 128,
                    regex: RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$'),
                    emptyText: "Password field mandatory",
                    regexText:
                        "Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordTextField(
                    controller: _repeatPassController,
                    hintText: "Confirm",
                    maxLength: 128,
                    regex: RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$'),
                    emptyText: "Password  field mandatory",
                    regexText:
                        "Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    text: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () async {
                      if (_signupFormKey.currentState!.validate()) {
                        if (_passController.text.length < 12) {
                          showToast(
                              "Password must be at least 12 characters in length");
                        } else {
                          if (_passController.text ==
                              _repeatPassController.text) {
                            if (status == true) {
                              await overlay.during(
                                  Future.delayed(const Duration(seconds: 1)));
                            }
                            signup();
                            setState(() {
                              status = false;
                            });
                          } else {
                            showToast("Password did not match");
                          }
                        }
                      }
                    },
                    height: 0.08,
                    width: 0.3,
                  ),
                ]),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
