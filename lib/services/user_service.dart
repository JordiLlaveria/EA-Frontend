import 'dart:convert';
import 'dart:developer';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class UserService {
  static const apiURL =
      String.fromEnvironment('API_URL', defaultValue: 'http://localhost:3000');
  static var baseURL = apiURL + "/api/users";
  static final LocalStorage storage = LocalStorage('Users');

  static Future<User> getUserByName(String name) async {
    var res = await http.get(Uri.parse(baseURL + '/' + name));
    var decoded = jsonDecode(res.body);
    return User.fromJson(decoded);
  }

  static Future<List<User>> getUsers() async {
    var res = await http.get(Uri.parse(baseURL));
    List<User> allUsers = [];
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded.forEach((customer) => allUsers.add(User.fromJson(customer)));
      return allUsers;
    }
    return [];
  }

  static Future<User> getUserByID(String id) async {
    var res = await http.get(Uri.parse(baseURL + '/byID/' + id));
    var decoded = jsonDecode(res.body);
    storage.setItem('username', User.fromJson(decoded).username);
    print("The user by id has been found");
    return User.fromJson(decoded);
  }

  static Future<void> updateUserByID(String id, String token,
      List<dynamic> peopleliked, List<dynamic> peopledisliked) async {
    print("Inside updatting user");
    var res = await http.put(Uri.parse(baseURL + '/byID/' + id),
        headers: {'content-type': 'application/json', 'x-access-token': token},
        body: json.encode(
            {"peopleliked": peopleliked, "peopledisliked": peopledisliked}));
  }
}
