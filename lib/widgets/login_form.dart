import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/screens/app_screen.dart';
import 'package:frontend/screens/index_screen.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/widgets/input_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  AuthService service = AuthService();

  GlobalKey<FormState> _formkey = GlobalKey();
  late String _user;
  late String _password;

  _submit() {
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
            label: 'User Name',
            hint: 'User Name',
            icon: Icon(Icons.verified_user),
            keyboard: TextInputType.emailAddress,
            onChanged: (data) {
              _user = data;
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
            onChanged: (data) {
              _password = data;
            },
          ),
          Divider(
            height: 25.0,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              //color: Color.fromARGB(255, 231, 103, 11),
              onPressed: () async {
                if (await service.login(_user, _password)) {
                  final route =
                      MaterialPageRoute(builder: (context) => AppScreen());
                  Navigator.push(context, route);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('USER OR PASSWORD INCORRECT'),
                            content: Text(
                                'The User or Paswword do not match with any user in database'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ));
                }
              },
              child: Text(
                'SIGN IN',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontFamily: 'FredokOne'),
              ),
            ),
          ),
          Divider(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New in Xerra? Try to',
                style: TextStyle(fontFamily: 'FredokaOne'),
              ),
              TextButton(
                onPressed: () {
                  final route =
                      MaterialPageRoute(builder: (context) => RegisterScreen());
                  Navigator.push(context, route);
                },
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      color: Color.fromARGB(255, 224, 239, 9),
                      fontFamily: 'FredokaOne'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
