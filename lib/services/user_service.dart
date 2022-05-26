import 'dart:convert';
import 'dart:developer';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService{
  static const apiURL = String.fromEnvironment('API_URL', defaultValue: 'https://ea1-backend.mooo.com');
  static var baseurl = apiURL + "/api/users";

  static Future<User> getUserByName(String name) async {
    var res = await http
        .get(Uri.parse("http://localhost:3000/api/users" + '/' + name));
    var decoded = jsonDecode(res.body);
    return User.fromJson(decoded);
  }

  Future<List<User>> getUsers() async {
    var res = await http.get(Uri.parse(baseurl));
    List<User> allUsers = [];
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded.forEach((customer) => allUsers.add(User.fromJson(customer)));
      return allUsers;
    }
    return [];
  }
}
  static Future<User> getUserByID(String id) async {
    var res = await http.get(Uri.parse(baseurl + '/byID/' + id));
    var decoded = jsonDecode(res.body);
    return User.fromJson(decoded);
  }
}
