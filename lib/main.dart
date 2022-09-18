// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/screens/Ximo_screen.dart';
import 'package:amazon/features/auth/screens/emailVerification_screen.dart';
import 'package:amazon/features/auth/screens/login_screen.dart';
import 'package:amazon/features/auth/screens/auth_screens.dart';
import 'package:amazon/providers/user_providers.dart';
import 'package:amazon/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/services/auth_service.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => AuthService()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final user = Provider.of<UserProvider>(context).user;

    @override
    void initState() {
      super.initState();
      authService.getUserData(context);
    }

    return MaterialApp(
      title: 'Ximo',
      theme: ThemeData(
        scaffoldBackgroundColor: globalV.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: globalV.ximoColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: user.token.isEmpty ? const LoginScreen() : const AmazonScreen()
    );
  }
}
