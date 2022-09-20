import 'package:flutter/material.dart';
import 'package:ximo/common/widgets/custom_button.dart';
import 'package:ximo/constants/global_variables.dart';
import 'package:ximo/features/auth/screens/Traditional_login_screen.dart';
import 'package:ximo/features/auth/screens/signUp_screen.dart';

import '../../../common/widgets/custom_horizontalLine.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen-google-facebook';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double paddingSize = width / height;
    double t5percentScreen = height * (20 / 100);

    return Scaffold(
      backgroundColor: globalV.backgroundColor,
      body: Column(children: [
        SizedBox(
          height: t5percentScreen,
          width: width,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: Color.fromRGBO(152, 255, 152, 30),
            ),
          ),
        ),
        SizedBox(
            height: t5percentScreen,
            width: width,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(152, 255, 152, 30),
                    Color.fromRGBO(0, 200, 197, 30),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  "Xmo",
                  style: TextStyle(
                    fontSize: 65,
                    fontFamily: "RobotoMono",
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 42, 71, 100),
                  ),
                ),
              ),
            )),
        SizedBox(
          height: t5percentScreen,
          width: width,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 200, 197, 30),
            ),
          ),
        ),
        SizedBox(
          height: height * (5 / 100),
        ),
        CustomButton(
          text: const Text("Log In"),
          onTap: () => {
            Navigator.pushNamedAndRemoveUntil(
              context,
              TraditionalLoginScreen.routeName,
              (Route<dynamic> route) => true,
            )
          },
          width: width * 0.002,
          height: height * 0.0001,
        ),
        SizedBox(
          height: height * 0.15 ,
          child: HorizontalLine(
            label: "OR",
            height: height * 0.05,
            colour: globalV.ximoColor,
          ),
        ),
        CustomButton(
          text: const Text("New to Xmo? Sign up here"),
          onTap: () => {
            Navigator.pushNamedAndRemoveUntil(
              context,
              SignUpScreen.routeName,
              (Route<dynamic> route) => true,
            )
          },
          width: width * 0.002,
          height: height * 0.0001,
        ),
      ]),
    );
  }
}
