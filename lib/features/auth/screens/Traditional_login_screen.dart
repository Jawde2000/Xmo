import 'package:ximo/common/widgets/custom_button.dart';
import 'package:ximo/common/widgets/custom_horizontalLine.dart';
import 'package:ximo/common/widgets/custom_textfield.dart';
import 'package:ximo/constants/global_variables.dart';
import 'package:ximo/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/custom_passwordtextfield.dart';
import 'signUp_screen.dart';

class TraditionalLoginScreen extends StatefulWidget {
  static const String routeName = '/traditional-login';
  const TraditionalLoginScreen({Key? key}) : super(key: key);

  @override
  State<TraditionalLoginScreen> createState() => _TraditionalLoginScreenState();
}

class _TraditionalLoginScreenState extends State<TraditionalLoginScreen> {
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double paddingSize = width / height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globalV.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(height / 47),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back!",
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
              padding: EdgeInsets.all(paddingSize * 40),
              child: Form(
                  key: _signinFormKey,
                  child: Column(children: [
                    SizedBox(
                      height: paddingSize * 5,
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
                    SizedBox(
                      height: paddingSize * 25,
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
                    SizedBox(
                      height: paddingSize * 25,
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
                      height: 0.06,
                      width: 0.3,
                    ),
                    SizedBox(
                      height: paddingSize * 25,
                    ),
                    HorizontalLine(
                      label: "OR",
                      height: width * 0.03,
                      colour: globalV.ximoColor,
                    ),
                    SizedBox(
                      height: paddingSize * 15,
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
                      height: 0.06,
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
