import 'dart:convert';
import 'package:http/http.dart' as http;


class RegisterService{
  var baseurl = "http://localhost:3000/api/auth/register";

  Future<bool> register(String name, String surname, String username, String password, String email, String phone, String mail, List<String> languages, List<String> location) async {
    var res = await http.post(Uri.parse(baseurl),
        headers: {'content-type': 'application/json'},
        body: json.encode({"name": name, "surname": surname, "username": username,"password": password, "email": email, "phone": phone, "mail": mail, "languages": languages, "location": location}));

    if (res.statusCode == 200) return true;
    return false;
  }
}