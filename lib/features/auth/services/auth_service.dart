import 'dart:convert';
import 'dart:html';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/auth/screens/amazon_screen.dart';
import 'package:amazon/features/auth/screens/emailVerification_screen.dart';
import 'package:amazon/features/auth/services/email_service.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/models/verification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AuthService {
  void signUp({
    required BuildContext context,
    required String email,
    required String pass,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          pass: pass,
          email: email,
          address: '',
          userType: '',
          token: '',
          emailVerified: '');

      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                "You have successfully created an account, an verification will be send to your email");
            Future.delayed(const Duration(seconds: 2), () => "2");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VerificationScreen(email: email)));
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logIn(
      {required BuildContext context,
      required String email,
      required String pass}) async {
    try {
      User user = User(
          id: '',
          name: '',
          pass: pass,
          email: email,
          address: '',
          userType: '',
          token: '',
          emailVerified: '');

      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            "email": email,
            "pass": pass,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Acccount Logged In");
            Future.delayed(const Duration(seconds: 2), () => "2");
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AmazonScreen()));
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //ignore: non_constant_identifier_names
  void verified(
      {required BuildContext context,
      required String email,
      required String D6_number}) async {
    try {
      Verification verification =
          Verification(id: '', email: email, D6_Number: D6_number, token: '');

      http.Response response =
          await http.post(Uri.parse('$uri/api/verification'),
              body: jsonEncode({
                "email": email,
                "validationNumber": D6_number,
              }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      http.Response response2 =
          await http.patch(Uri.parse('$uri/api/updateStatus'),
              body: jsonEncode({
                "email": email,
              }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            httpErrorHandle(
                response: response2,
                context: context,
                onSuccess: () {
                  Future.delayed(const Duration(seconds: 2), () => "2");
                });
            showSnackBar(context, "Acccount Logging In");
            Future.delayed(const Duration(seconds: 2), () => "2");
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AmazonScreen()));
          });
    } catch (e) {
      //showSnackBar(context, e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  void VerificationTimedout(
      {required BuildContext context, required email}) async {
    try {
      Verification verification =
          Verification(id: '', email: email, D6_Number: '', token: '');

      http.Response response =
          await http.post(Uri.parse('$uri/api/VerificationTimedOut'),
              body: jsonEncode({
                "email": email,
              }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Verification Timed Out");
          });
    } catch (error) {
      //showSnackBar(context, e.toString());
    }
  }
}
