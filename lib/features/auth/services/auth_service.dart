import 'dart:convert';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/auth/screens/amazon_screen.dart';
import 'package:amazon/features/auth/screens/emailVerification_screen.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/models/verification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../common/widgets/custom_loadingIndicator.dart';

class AuthService extends ChangeNotifier {
  bool ServerStatus = false;

  void signUp({
    required BuildContext context,
    required String email,
    required String pass,
    required String name,
  }) async {
    final overlay = LoadingOverlay.of(context);
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

      await overlay.during(Future.delayed(const Duration(seconds: 1)));

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
    final overlay = LoadingOverlay.of(context);

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

      await overlay.during(Future.delayed(const Duration(seconds: 1)));

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            Future.delayed(const Duration(seconds: 2), () => "2");
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => const AmazonScreen()));

            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const AmazonScreen(),
            //         maintainState: false),
            //     (Route<dynamic> route) => false);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificationScreen(email: email),
                    maintainState: false),
                (Route<dynamic> route) => false);
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
    final overlay = LoadingOverlay.of(context);

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

      await overlay.during(Future.delayed(const Duration(seconds: 1)));

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            http.Response response2 =
                await http.patch(Uri.parse('$uri/api/updateStatus'),
                    body: jsonEncode({
                      "email": email,
                    }),
                    headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                });

            httpErrorHandle(
                response: response2,
                context: context,
                onSuccess: () {
                  Future.delayed(const Duration(seconds: 2), () => "2");
                });
            // ignore: use_build_context_synchronously
            showSnackBar(context, "Acccount Logging In");
            Future.delayed(const Duration(seconds: 2), () => "2");
            // ignore: use_build_context_synchronously
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => const AmazonScreen()));
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const AmazonScreen(),
                    maintainState: false),
                (Route<dynamic> route) => false);
          });
    } catch (e) {
      //showSnackBar(context, e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  void deleteOTP(
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

      httpErrorHandle(response: response, context: context, onSuccess: () {});
    } catch (error) {
      //showSnackBar(context, e.toString());
    }
  }

  void resendOTP({required BuildContext context, required String email}) async {
    final overlay = LoadingOverlay.of(context);

    try {
      http.Response response = await http.post(Uri.parse('$uri/api/sendOTP'),
          body: jsonEncode({
            "email": email,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      await overlay.during(Future.delayed(const Duration(seconds: 1)));

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            ServerStatus = true;
            notifyListeners();
            showSnackBar(context, "New OTP code have been sent");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
