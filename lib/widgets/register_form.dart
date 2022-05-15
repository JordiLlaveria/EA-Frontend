import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/service/registerService.dart';

import '../screens/app_screen.dart';
import 'input_text.dart';

class RegisterForm extends StatefulWidget{
  const RegisterForm({Key? key}) : super(key: key);
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final _formKey =  GlobalKey<FormState>();

  late String name;
  late String surname;
  late String username;
  late String password1;
  late String password2;
  late String email;
  late String phone;
  late List<String> location;
  late List<String> languages;

  RegisterService service = RegisterService();

  @override
  Widget build(BuildContext context) {  
      

    final nameField = InputText(
      label: 'Your name', 
      hint: 'Name', 
      icon: Icon(Icons.account_box), 
      keyboard: TextInputType.name,
      onChanged: (data){
        name= data;
      },
    );

    final surnameField = InputText(    
      label: 'Your surname',
      hint: 'Surname',
      icon: Icon(Icons.account_box_outlined),  
      keyboard: TextInputType.name,      
      onChanged: (data){
        surname = data;
      },      
      
    );

    final usernameField = InputText(
      label: 'Choose a username',
      hint: 'Username',
      icon: Icon(Icons.sentiment_satisfied),
      keyboard: TextInputType.name,
      onChanged: (data){
        username = data;
      },
    );

    final password1Field = InputText(
      label: 'Choose your password',
      hint: 'Password',
      icon: Icon(Icons.lock),
      obsecure: true,
      onChanged: (data){
        password1 = data;
      },
    );

    final password2Field = InputText(
      label: 'Repeat your password',
      hint: 'Password',
      icon: Icon(Icons.lock),
      obsecure: true,
      onChanged: (data){
        password2 = data;
      },
    );  

    final emailField = InputText(
      label: 'Your email',
      hint: 'Email',
      keyboard: TextInputType.emailAddress,
      icon: Icon(Icons.email),
      onChanged: (data){
        email = data;
      },
    );

    final phoneField = InputText(
      label: "Your phone",
      hint: 'Phone',
      keyboard: TextInputType.phone,
      icon: Icon(Icons.phone),
      onChanged: (data){
        phone = data;
      },
    );

    final locationField = InputText(
      label: 'Coordinates of your location',
      hint: "[Longitude],[Latitude]",
      keyboard: TextInputType.text,
      icon: Icon(Icons.add_location_alt),
      onChanged: (data){
        location = data.split(',');
      },
    );    

    final languagesField = InputText(
      label: 'Languages you speak',
      hint: 'Languages',
      keyboard: TextInputType.text,
      icon: Icon(Icons.chat_bubble_outline),
      onChanged: (data){
        languages = data.split(',');
      },
    );    

    final registerButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: ()async{
          _register();
        },
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      
    );

    return Form(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          nameField,
          SizedBox(height: 20),
          surnameField,
          SizedBox(height: 20),
          usernameField,
          SizedBox(height: 20),
          password1Field,
          SizedBox(height: 20),
          password2Field,
          SizedBox(height: 20),
          emailField,
          SizedBox(height: 20),
          phoneField,
          SizedBox(height: 20),
          locationField,
          SizedBox(height: 20),
          languagesField,
          SizedBox(height: 20),
          registerButton,
          SizedBox(height: 20),
        ],
      )
    );
    
  }
  
    

  void _register() async{
    //if(_formKey.currentState!.validate()){
      if(password1 == password2){
        if(await service.register(name, surname, username, password1, email, phone, email, languages, location)){
            final route = MaterialPageRoute(
              builder: (context) => App());
            Navigator.push(context, route); 
        };
      }
      else{

      }
    //}

  }
}