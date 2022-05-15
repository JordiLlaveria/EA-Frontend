import 'package:flutter/material.dart';
import 'package:frontend/models/loginService.dart';
import 'package:frontend/widgets/login_form.dart';
import '../widgets/icon_container.dart';

class SignIn extends StatefulWidget {
  SignIn({ Key? key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
            children: <Widget> [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                IconContainer(
                url: 'imatges/Logo.PNG'
                ),
                Text(
                  'SIGIN',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'FredokaOne'
                  ),
                ),
                Divider(
                  height: 10.0,
                ),
                //Formulari
                LoginForm()
              ],
            )
          ],
        ),
      ),
    ),
    );
  }
}