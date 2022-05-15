import 'dart:convert';
import 'package:http/http.dart' as http;


class LoginService{
  var baseurl = "http://localhost:3000/api/auth";

  Future<bool> login(String email, String password) async {
    var res = await http.post(Uri.parse(baseurl),
        headers: {'content-type': 'application/json'},
        body: json.encode({"email": email, "password": password}));

    if (res.statusCode == 200) return true;
    return false;
  }
}