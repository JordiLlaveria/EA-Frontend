import 'package:flutter/material.dart';

import '../widgets/input_text.dart';
import '../models/user_model.dart';
import '../screens/search_screen.dart';

class FilterUser extends StatefulWidget {
  final List<User> users;
  FilterUser({Key? key, required this.users}) : super(key: key);

  @override
  State<FilterUser> createState() => _FilterUserState(users: users);
}

class _FilterUserState extends State<FilterUser> {
  List<User> users;
  _FilterUserState({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 121, 135, 150),
      ], begin: Alignment.topCenter)),
      child: ListView(
        children: <Widget>[
          Column(),
          SizedBox(height: 20),
          InputText(
            label: 'Your name',
            hint: 'Name',
            keyboard: TextInputType.name,
            icon: Icon(Icons.account_box),
            onChanged: (data) {
              //name = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Your surname',
            hint: 'Surname',
            keyboard: TextInputType.name,
            icon: Icon(Icons.account_box_outlined),
            onChanged: (data) {
              //surname = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Choose a username',
            hint: 'Username',
            keyboard: TextInputType.name,
            icon: Icon(Icons.sentiment_satisfied),
            onChanged: (data) {
              //username = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Choose a password',
            hint: 'Password',
            obsecure: true,
            icon: Icon(Icons.lock),
            onChanged: (data) {
              //password1 = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Repeat your password',
            hint: 'Password',
            obsecure: true,
            icon: Icon(Icons.lock),
            onChanged: (data) {
              //password2 = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Your email',
            hint: 'Email',
            keyboard: TextInputType.emailAddress,
            icon: Icon(Icons.email),
            onChanged: (data) {
              //email = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Your phone',
            hint: 'Phone',
            keyboard: TextInputType.phone,
            icon: Icon(Icons.phone),
            onChanged: (data) {
              //phone = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Write your languages',
            hint: 'Languages',
            keyboard: TextInputType.text,
            icon: Icon(Icons.chat_bubble_outline),
            onChanged: (data) {
              //languages = data.split(',');
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Write your location',
            hint: '[Longitude],[Latitude]',
            keyboard: TextInputType.text,
            icon: Icon(Icons.add_location_alt),
            onChanged: (data) {
              //location = data.split(',');
            },
          ),
          SizedBox(height: 20),
          Material(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey,
            child: MaterialButton(
              padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                final route = MaterialPageRoute(
                    builder: (context) => FilterUser(users: users));
                Navigator.push(context, route);
              },
              child: Text(
                "Come back to search screen",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    ));
  }
}
