import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';

class DistanceScreen extends StatefulWidget {
  @override
  _DistanceScreenState createState() => _DistanceScreenState();
}

class _DistanceScreenState extends State<DistanceScreen> {
  UserService userService = UserService();
  List<User> users = [];
  late String name;
  var storage;
  var id;

  void initState() {
    super.initState();
    getUsers();
  }

  Future<List<User>> getUsers() async {

    storage = LocalStorage('Users');
    await storage.ready;
    id = storage.getItem('userID');
    users = await UserService.getUsersByDistance("10", id);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            margin: EdgeInsets.all(2),
            child: Center(
              child: Text('${users[index].name}',
                style: TextStyle(fontSize: 18),
              )
            ),
          );
        }
      )    
    );
  }
 
}
