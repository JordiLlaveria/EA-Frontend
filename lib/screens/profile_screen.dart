import 'package:flutter/material.dart';
import 'package:frontend/services/profileService.dart';

import '../widgets/icon_container.dart';
import '../widgets/profile_form.dart';
import 'app_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Widget build(BuildContext context) {
    return Container(
      child:  Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromARGB(255, 166, 105, 44),
                Color.fromARGB(255, 181, 37, 76)
              ],
              begin: Alignment.topCenter
            )
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 200
            ),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconContainer(
                  url: 'imatges/Logo.PNG'
                  ),
                  Text(
                    'PROFILE',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'FredokaOne'
                    ),
                  ),
                  Divider(
                    height: 10.0,
                  ),
                  ProfileForm()                
                ],
              )
            ],
          ),
        ),       

      ),
    );
  }  
}