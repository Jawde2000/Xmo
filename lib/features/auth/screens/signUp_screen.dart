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

  void verification() {
    
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
                key: _signupFormKey,
                child: Column(children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _nameController,
                    hintText: "Name",
                    maxLength: 50,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _mailController,
                    hintText: "Email",
                    maxLength: 320,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _passController,
                    hintText: "Password",
                    maxLength: 128,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _repeatPassController,
                    hintText: "Enter your password again",
                    maxLength: 128,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      text: "Sign Up",
                      onTap: () {
                        if (_passController.text ==
                            _repeatPassController.text) {
                          if (_signupFormKey.currentState!.validate()) {
                            signup();
                          }
                        } else {
                          showToast("Password Did Not Match");
                        }
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
