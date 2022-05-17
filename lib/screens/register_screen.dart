import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';

import '../widgets/icon_container.dart';
import '../widgets/register_form.dart';
import 'app_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'FredokaOne'
                    ),
                  ),
                  Divider(
                    height: 10.0,
                  ),
                  RegisterForm()                
                ],
              )
            ],
          ),
        ),       

      ),
    );
  }  
}