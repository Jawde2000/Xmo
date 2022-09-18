import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  signup,
  signin,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signin;
  final _signupFormKey = GlobalKey<FormState>();
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
            ListTile(
              tileColor: _auth == Auth.signup
                  ? globalV.backgroundColor
                  : globalV.greyBackgroundCOlor,
              title: const Text(
                "Create An Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: globalV.ximoColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signup)
              (Container(
                padding: const EdgeInsets.all(8.0),
                color: globalV.backgroundColor,
                child: Form(
                  key: _signupFormKey,
                  child: Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      controller: _nameController,
                      hintText: "Name",
                      maxLength: 128,
                      regex: RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$'),
                      emptyText: "Please enter your password",
                      regexText:
                          "Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and must be 12 characters in length",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      controller: _mailController,
                      hintText: "Email",
                      maxLength: 128,
                      regex: RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$'),
                      emptyText: "Please enter your password",
                      regexText:
                          "Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and must be 12 characters in length",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      controller: _passController,
                      hintText: "Password",
                      maxLength: 128,
                      regex: RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$'),
                      emptyText: "Please enter your password",
                      regexText:
                          "Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and must be 12 characters in length",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      controller: _repeatPassController,
                      hintText: "Enter your password again",
                      maxLength: 128,
                      regex: RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$'),
                      emptyText: "Please enter your password",
                      regexText:
                          "Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and must be 12 characters in length",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: const Text("Sign Up"),
                      onTap: () {
                        if (_passController.text ==
                            _repeatPassController.text) {
                          if (_signupFormKey.currentState!.validate()) {
                            signup();
                          }
                        } else {
                          showToast("Password Did Not Match");
                        }
                      },
                      height: 30,
                      width: 30,
                    ),
                  ]),
                ),
              )),
            ListTile(
              tileColor: _auth == Auth.signin
                  ? globalV.backgroundColor
                  : globalV.greyBackgroundCOlor,
              title: const Text(
                "Sign In",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: globalV.ximoColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signin)
              (Container(
                  padding: const EdgeInsets.all(8.0),
                  color: globalV.backgroundColor,
                  child: Form(
                    key: _signinFormKey,
                    child: Column(children: [
                      CustomTextField(
                        controller: _mailController,
                        hintText: "Enter your email",
                        maxLength: 128,
                        regex: RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$'),
                        emptyText: "Please enter your password",
                        regexText:
                            "Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and must be 12 characters in length",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _passController,
                        hintText: "Enter your password",
                        maxLength: 128,
                        regex: RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$'),
                        emptyText: "Please enter your password",
                        regexText:
                            "Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and must be 12 characters in length",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        text: const Text("Log In"),
                        onTap: () {
                          if (_signinFormKey.currentState!.validate()) {
                            login();
                          }
                        },
                        height: 30,
                        width: 30,
                      )
                    ]),
                  ))),
          ],
        ),
      )),
    );
  }
}
