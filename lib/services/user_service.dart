import 'dart:convert';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;


class UserService{
  static const apiURL = String.fromEnvironment('API_URL', defaultValue: 'https://ea1-backend.mooo.com');
  static var baseurl = apiURL + "/api/users";

  static Future<User> getUserByName(String name) async {
    var res = await http.get(Uri.parse(baseurl + '/' + name));
    var decoded = jsonDecode(res.body);
    return User.fromJson(decoded);
  }

  static Future<User> getUserByID(String id) async {
    var res = await http.get(Uri.parse(baseurl + '/byID/' + id));
    var decoded = jsonDecode(res.body);
    return User.fromJson(decoded);
  }
}