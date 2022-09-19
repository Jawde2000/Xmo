import 'package:ximo/common/widgets/custom_button.dart';
import 'package:ximo/common/widgets/custom_horizontalLine.dart';
import 'package:ximo/common/widgets/custom_textfield.dart';
import 'package:ximo/constants/global_variables.dart';
import 'package:ximo/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
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
  final double borderRadius = 12;

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
        pass: _passController.text,
        name: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalV.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Xmo",
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
                      emptyText: "Password field mandatory",
                      regexText:
                          "Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and must be 12 characters in length",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: const Text("Log In",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      onTap: () async {
                        if (_signinFormKey.currentState!.validate()) {
                          login();
                        }
                      },
                      height: 0.08,
                      width: 0.3,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const HorizontalLine(
                        label: "OR", height: 5, colour: globalV.ximoColor),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: const Text(
                        "New user? Sign in here",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () => {
                        Navigator.pushNamed(context, SignUpScreen.routeName)
                      },
                      height: 0.08,
                      width: 0.5,
                    ),
                  ])),
            ),
          ],
        ),
      )),
    );
  }
}
