import 'dart:convert';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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
          token: '');

      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "You have successfully created an account, an verification will be send to your email");
            
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
          token: '');

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
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
