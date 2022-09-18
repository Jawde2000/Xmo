import 'package:amazon/common/widgets/custom_navbar.dart';
import 'package:amazon/features/auth/screens/Ximo_screen.dart';
import 'package:amazon/features/auth/screens/auth_screens.dart';
import 'package:amazon/features/auth/screens/login_screen.dart';
import 'package:amazon/features/auth/screens/signUp_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignUpScreen());
    case AmazonScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AmazonScreen());
    case NavBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const NavBar());
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist"),
          ),
        ),
      );
  }
}
