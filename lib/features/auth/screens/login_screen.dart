import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_horizontalLine.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../common/widgets/custom_loadingIndicator.dart';
import '../../../common/widgets/custom_passwordtextfield.dart';
import 'signUp_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/auth-screen2';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _signinFormKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _passController.dispose();
    _nameController.dispose();
  }

  void login() async {
    authService.logIn(
        context: context,
        email: _mailController.text,
        pass: _passController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalV.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.all(8.0),
              color: globalV.backgroundColor,
              child: Form(
                  key: _signinFormKey,
                  child: Column(children: [
                    const SizedBox(
                      height: 45,
                    ),
                    CustomTextField(
                      controller: _mailController,
                      hintText: "Email address",
                      maxLength: 320,
                      regex: RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                      emptyText: "Email field mandatory",
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
                      emptyText: "Password  field mandatory",
                      regexText:
                          "Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and must be 12 characters in length",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                        text: "Log In",
                        onTap: () async {
                          if (_signinFormKey.currentState!.validate()) {
                            login();
                          }
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    const HorizontalLine(
                        label: "OR", height: 5, colour: globalV.amazonColor),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                        text: "New user? Sign in here",
                        onTap: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()))
                            }),
                  ])),
            ),
          ],
        ),
      )),
    );
  }
}
