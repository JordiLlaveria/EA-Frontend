import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/models/loginService.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/sign_in.dart';
import 'package:frontend/widgets/input_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({ Key? key }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginService service = LoginService();

  GlobalKey<FormState> _formkey = GlobalKey();
  late String _email;
  late String _password;
  Future <bool> code = false as Future<bool>;
  _submit(){
    final isLoggin = _formkey.currentState?.validate();
    print('IsLoggin Form $isLoggin');
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          InputText(
            label: 'Email Address', 
            hint: 'Email Address', 
            icon: Icon(Icons.verified_user), 
            keyboard: TextInputType.emailAddress,
            onChanged: (data){
              _email= data;
            },
          ),
          Divider(
            height: 15.0,
          ),
          InputText(
            hint: 'Password',
            label: 'Password',
            obsecure: true,
            icon: Icon(Icons.lock_outline),
            onChanged: (data){
              _password = data;
            },
          ),
          Divider(
            height: 25.0,
          ),
          SizedBox(
            width: double.infinity,
            child: FlatButton(
              color: Color.fromARGB(255, 231, 103, 11),
              onPressed: (){
                future: code = service.login(_email, _password);
                if(code !=false){
                  final route = MaterialPageRoute(
                    builder: (context) => HomeScreen());
                  Navigator.push(context, route);
                }else{
                  //POSAR ALERT MESSAGE
                }
              },
              child: Text(
                'SIGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontFamily: 'FredokOne'
                ),
              ),
            ),
          ),
          Divider(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text(
                'New in Xerra? Try to',
                style: TextStyle(
                  fontFamily: 'FredokaOne'
                ),
              ),
              FlatButton(
                onPressed: (){
                  final route = MaterialPageRoute(
                        builder: (context) => SignIn()); //Canviar a SIGNUP!!
                      Navigator.push(context, route);
                },
                child: Text(
                  'SINGUP',
                  style: TextStyle(
                    color: Color.fromARGB(255, 224, 239, 9),
                    fontFamily: 'FredokaOne'
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}