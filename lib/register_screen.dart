import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget{
  Widget build(BuildContext context) {
    final appTitle = 'Register';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget{
  RegisterFormState createState(){
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm>{

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _emailInput(),
          _passwordInput(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: _registerButton()
          ),
        ],
      ),
    );
  }
  
}