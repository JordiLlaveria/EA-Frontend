import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import '../models/user_model.dart';

class AuthService {
  static const apiURL = String.fromEnvironment('API_URL',
      defaultValue:
          'http://localhost:3000');
  var baseURL = apiURL + "/api/auth";
  final LocalStorage storage = LocalStorage('Users');

  Future<bool> register(
      String name,
      String surname,
      String username,
      String password,
      String email,
      String phone,
      List<String> location,
      List<String> languages,
      String photo) async {
    var res = await http.post(Uri.parse(baseURL + '/register'),
        headers: {'content-type': 'application/json'},
        body: json.encode({
          "name": name,
          "surname": surname,
          "username": username,
          "password": password,
          "mail": email,
          "phone": phone,
          "location": location,
          "languages": languages,
          "photo": photo
        }));
    print("Register request has already been done");
    if (res.statusCode == 200) {
      print("Status 200 received");
      var token = Token.fromJson(await jsonDecode(res.body));
      storage.setItem('token', token.toString());
      Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
      storage.setItem('userID', payload['id']);
      storage.setItem('username', payload['username']);
      // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // await sharedPreferences.setString('user',payload['username']);
      // await sharedPreferences.setString('userId', payload['id']);
      return true;  
    } 
    return false;
  }

  Future<bool> login(String username, String password) async {
    var res = await http.post(Uri.parse(baseURL + '/login'),
        headers: {'content-type': 'application/json'},
        body: json.encode({"username": username, "password": password}));

    if (res.statusCode == 200) {
      print("User logged correctly");
      var token = Token.fromJson(await jsonDecode(res.body));
      storage.setItem('token', token.toString());
      print("The token of the user is " + token.toString());
      Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
      storage.setItem('userID', payload['id']);
      print("The id of the user is " + payload['id']);
      storage.setItem('username', payload['username']);
      print("The username of the user is " + payload['username']);

      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('user',payload['username']);
      await sharedPreferences.setString('userId', payload['id']);
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
