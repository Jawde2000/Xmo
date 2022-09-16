import 'package:amazon/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: "",
      name: "",
      pass: "",
      email: "",
      emailVerified: "",
      address: "",
      userType: "",
      token: "");

  User get user =>  _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
