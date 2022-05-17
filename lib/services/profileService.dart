import 'dart:convert';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;


class ProfileService{
  var baseurl = "http://localhost:3000/api/users";

  Future<UserModel> getUserByName(String name) async {
    var res = await http.get(Uri.parse(baseurl + '/' + name));
    var decoded = jsonDecode(res.body);
    return UserModel.fromJson(decoded);
  }
}