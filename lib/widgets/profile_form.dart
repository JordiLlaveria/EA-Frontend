import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/inputmod_text.dart';
import 'package:frontend/models/user_model.dart';
import 'dart:developer';
import '../screens/app_screen.dart';
import 'package:localstorage/localstorage.dart';

class ProfileForm extends StatefulWidget{
  const ProfileForm({ Key? key }) : super(key: key);
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm>{

  UserService service = UserService();
  GlobalKey<FormState> _formkey = GlobalKey();

  late String name;
  late String surname;
  late String username;
  late String password1;
  late String password2;
  late String email;
  late String phone;
  late List<String> languages;
  late List<String> location;

  late String id;
  var storage;
  Future<User> fetchUser() async {
    log("fetchUser");
    storage = LocalStorage('Users');
    await storage.ready;
    log("Abans storage");
    id = storage.getItem('userID');
    log("Despres storage");
    return UserService.getUserByID(id);
  }

  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureUser,
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return Form(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.name,
                    icon: Icon(Icons.account_box),
                    onChanged: (data){
                      name = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.surname,
                    icon: Icon(Icons.account_box_outlined),
                    onChanged: (data){
                      surname = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.username,
                    icon: Icon(Icons.sentiment_satisfied),
                    onChanged: (data){
                      username = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.password,
                    icon: Icon(Icons.lock),
                    onChanged: (data){
                      password1 = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.email,
                    icon: Icon(Icons.email),
                    onChanged: (data){
                      email = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.phone,
                    icon: Icon(Icons.phone),
                    onChanged: (data){
                      phone = data;
                    },
                  ),        
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.languages.toString(),
                    icon: Icon(Icons.chat_bubble_outline),
                    onChanged: (data){
                      languages = data.split(',');
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.location.toString(),
                    icon: Icon(Icons.add_location_alt),
                    onChanged: (data){
                      location = data.split(',');
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  } 
}