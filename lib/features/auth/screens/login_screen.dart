import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_horizontalLine.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _repeatPassController = TextEditingController();
  final AuthService authService = AuthService();
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

  void login() {
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
                    hintText: "Enter your email",
                    maxLength: 320,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _passController,
                    hintText: "Enter your password",
                    maxLength: 128,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      text: "Log In",
                      onTap: () {
                        if (_signinFormKey.currentState!.validate()) {
                          showLoadingStatus("Logging...", true);
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
                ]),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
