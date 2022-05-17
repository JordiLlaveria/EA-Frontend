import 'dart:convert';
import 'package:http/http.dart' as http;


class LoginService{
  var baseurl = "http://147.83.7.156:3000/api/auth/login";

  Future<bool> login(String username, String password) async {
    var res = await http.post(Uri.parse(baseurl),
        headers: {'content-type': 'application/json'},
        body: json.encode({"username": username, "password": password}));

    if (res.statusCode == 200) return true;
    return false;
  }
}