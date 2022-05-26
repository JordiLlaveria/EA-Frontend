import 'dart:convert';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class UserService{
  static const apiURL = String.fromEnvironment('API_URL', defaultValue: 'http://localhost:3000');
  static var baseurl = apiURL + "/api/users";
  static final LocalStorage storage = LocalStorage('Users');

  static Future<User> getUserByName(String name) async {
    var res = await http.get(Uri.parse(baseurl + '/' + name));
    var decoded = jsonDecode(res.body);
    return User.fromJson(decoded);
  }

  static Future<User> getUserByID(String id) async {
    var res = await http.get(Uri.parse(baseurl + '/byID/' + id));
    var decoded = jsonDecode(res.body);
    storage.setItem('username', User.fromJson(decoded).username);
    return User.fromJson(decoded);
  }
}