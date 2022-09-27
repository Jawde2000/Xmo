import 'package:ximo/common/widgets/custom_navbar.dart';
import 'package:ximo/features/auth/screens/Xmo_screen.dart';
import 'package:ximo/features/auth/screens/Traditional_login_screen.dart';
import 'package:ximo/features/auth/screens/add_recommendation.dart';
import 'package:ximo/features/auth/screens/login_screen.dart';
import 'package:ximo/features/auth/screens/signUp_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case TraditionalLoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TraditionalLoginScreen(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignUpScreen());
    case XmoScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const XmoScreen());
    case NavBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const NavBar());
    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());
    case addRecommendation.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const addRecommendation());
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
