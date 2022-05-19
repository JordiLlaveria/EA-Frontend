import 'dart:convert';
import 'dart:developer';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  static var baseurl = "http://localhost:3000/api/users";

  static Future<User> getUserByName(String name) async {
    var res = await http.get(Uri.parse(baseurl + '/' + name));
    var decoded = jsonDecode(res.body);
    return User.fromJson(decoded);
  }

  static Future<List<dynamic>> getUsers() async {
    var res = await http.get(Uri.parse(baseurl + "/"));
    List<dynamic> values = [];
    List<User> users = [];
    values = json.decode(res.body);
    values.forEach((user) {
      final User userfound = User.fromJson(user);
      users.add(userfound);
    });
    return users;
  }
}
