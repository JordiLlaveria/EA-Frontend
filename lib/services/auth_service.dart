import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:developer';

class AuthService{
  var baseurl = "https://ea1-backend.mooo.com/api/auth";
  final LocalStorage storage = LocalStorage('Users');

  Future<bool> register(String name, String surname, String username, String password, String email, String phone, List<String> languages, List<String> location) async {
    var res = await http.post(Uri.parse(baseurl + '/register'),
        headers: {'content-type': 'application/json'},
        body: json.encode({"name": name, "surname": surname, "username": username, "password": password, "mail": email, "phone": phone, "location": location, "languages": languages}));

    if (res.statusCode == 200){
      var token = Token.fromJson(await jsonDecode(res.body));
      storage.setItem('token', token.toString());
      Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
      storage.setItem('userID', payload['id']);
      storage.setItem('userName', name);
      return true;  
    } 
    return false;
  }

  Future<bool> login(String username, String password) async {
      var res = await http.post(Uri.parse(baseurl + '/login'),
          headers: {'content-type': 'application/json'},
          body: json.encode({"username": username, "password": password}));

      if (res.statusCode == 200){
        var token = Token.fromJson(await jsonDecode(res.body));
        storage.setItem('token', token.toString());
        Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
        storage.setItem('userID', payload['id']);
        //name?
        return true;
      }
      return false;
    }
}

class Token {
  final String token;

  const Token({
    required this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token'] as String,
    );
  }

  @override
  String toString() {
    return token;
  }
}