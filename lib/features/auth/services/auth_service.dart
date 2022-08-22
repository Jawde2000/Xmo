import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUp({
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

      http.Response response = await http.post(Uri.parse('$url/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8'
          });
    } catch (e) {}
  }
}
