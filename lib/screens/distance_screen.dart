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
  late String name;
  var storage;
  var id;
  

  Future<List<User>> getUsers() async {

    storage = LocalStorage('Users');
    await storage.ready;
    id = storage.getItem('userID');
    return UserService.getUsersByDistance("10000", id);
  }

   late Future<List<User>> users;

   void initState() {
    super.initState();
    users = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: users,
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        if(snapshot.hasData){
          return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: snapshot.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            margin: EdgeInsets.all(2),
            child: Center(
              child: Text('${snapshot.data![index].name}',
                style: TextStyle(fontSize: 18),
              )
            ),
          );
        }
      )    
    );
        }
        else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
      });
    
  }
 
}
