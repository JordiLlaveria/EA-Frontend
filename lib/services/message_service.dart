import 'dart:convert';
import 'dart:developer';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../helper/preferences_helper.dart';
import '../models/chat_model.dart';

class MessageService {
  static final header = {"Content-Type": "application/json"};
  static const apiURL = String.fromEnvironment('API_URL',
      defaultValue: 'http://localhost:3000');
  static var baseURL = apiURL + "/api/messages";
  static final LocalStorage storage = LocalStorage('Users');

/*   // Fetch Shuffle List -> getUserList?
  Future<List<User>> fetchShuffleList() async {
    var token = await SharedPreferencesHelper.shared.getUserToken();
    var body = json.encode({"token" : token});
    var response = await http.post(Uri.parse(baseURL + "/user/shuffle",
        headers: header,body: body);

    if (response.statusCode == 200) {
      var list = (json.decode(response.body) as List)
          .map((element) => User.fromJson(element))
          .toList();
      return list;
    } else {
      return List<User>();
    }
  } */

  static Future<List<Chat>> fetchMessageList(String receiverID) async {
    var myID = await SharedPreferencesHelper.shared.getMyID();
    var body = json.encode({"sender" : myID, "receiver" : receiverID});
    var response = await http.post(Uri.parse(baseURL + "/fetchChat"),
      headers: header,
      body: body);

    if(response.statusCode == 200){
      var list = (json.decode(response.body) as List).map((e) => Chat.fromJson(e)).toList();
      return list;
    }else{
      return <Chat>[];
    }
  }
}
