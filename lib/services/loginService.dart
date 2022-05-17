import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class LoginService{
  var baseurl = "http://localhost:3000/api/auth/login";
/*   final LocalStorage storage = LocalStorage('Users'); */

  Future<bool> login(String username, String password) async {
    var res = await http.post(Uri.parse(baseurl),
        headers: {'content-type': 'application/json'},
        body: json.encode({"username": username, "password": password}));

    if (res.statusCode == 200){
/*       storage.setItem('userId', payload['id']); */
      return true;
    }
    return false;
  }
}