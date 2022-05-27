import 'dart:convert';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;


class UserService{
  static var baseurl = "https://ea1-backend.mooo.com/api/users";

  static Future<User> getUserByName(String name) async {
    var res = await http.get(Uri.parse(baseurl + '/' + name));
    var decoded = jsonDecode(res.body);
    return User.fromJson(decoded);
  }
}