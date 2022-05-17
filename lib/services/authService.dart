import 'dart:convert';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  var baseUrl = "http://localhost:3000/api/auth";

  //In Dart, promises are called Future.

  Future<bool> login(String username, String password) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: {'content-type': 'application/json'},
        body: json.encode({"username": username, "password": password}));

    if (res.statusCode == 200) return true;
    return false;
  }

  Future<String?> register(User user) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: {'content-type': 'application/json'},
        body: json.encode(User.toJson(user)));

    if (res.statusCode == 200) {
      String token = res.body;
      return token;
    }
    return null;
  }
}
