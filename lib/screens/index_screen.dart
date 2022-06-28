import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/app_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/register_google_screen.dart';
import 'package:frontend/widgets/icon_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/sign_google.dart';
import '../screens/app_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {

  Sign signup = Sign();
  late User? usergoogle;



  bool isLogged = false;
  String user = '';

  @override
  void initState() {
    super.initState();
  }

  void _signup(BuildContext contextuser) async {
    User? user = await signup.credentials(context: contextuser);
    if (user != null) {
      var parts = user.displayName?.split(' ');
      //Separamos el nombre completo que proporciona Google en nombre y apellido, porque así se muestra a los usuarios
      String? nameUserFound = parts![0].trim();
      String? surnameUserFound = parts[1].trim();
      //El username no es más que el nombre y apellido de manera unida
      String? usernameFound = nameUserFound + surnameUserFound;
      final route = MaterialPageRoute(
          builder: (context) => RegisterGoogleScreen(
                name: nameUserFound,
                surname: surnameUserFound,
                username: usernameFound,
                photo: user.photoURL,
                email: user.email,
              ));
      Navigator.push(context, route);
    }
  }

  void _afterlayaout(_) {
    Future.delayed(Duration(milliseconds: 100));
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
            Color.fromARGB(255, 166, 105, 44),
            Color.fromARGB(255, 181, 37, 76)
          ], begin: Alignment.topCenter)),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 200),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconContainer(url: 'imatges/Logo.PNG'),
                  Text(
                    'PROJECTE EA: XERRA',
                    style: TextStyle(fontFamily: 'FredokaOne', fontSize: 30.0),
                  ),
                  Text(
                    '[GRUP 1]',
                    style: TextStyle(
                        fontFamily: 'PermanentMarker', fontSize: 18.0),
                  ),
                  Divider(
                    height: 20.0,
                  ),
                  SizedBox(
                    
                    width: double.infinity,
                    height: 60.0,
                    child: TextButton(
                      onPressed: () {
                        final route = MaterialPageRoute(
                            builder: (context) => LoginScreen());
                        Navigator.push(context, route);
                      },
                      //color: Color.fromARGB(255, 226, 174, 15),
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'FredokaOne',
                            fontSize: 30.0),
                      ),
                    ),
                  ),
                  Divider(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60.0,
                    child: TextButton(
                      onPressed: () {
                        final route = MaterialPageRoute(
                            builder: (context) =>
                                RegisterScreen()); //Canviar a Signup
                        Navigator.push(context, route);
                      },
                      //color: Color.fromARGB(255, 229, 28, 85),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'FredokaOne',
                            fontSize: 30.0),
                      ),
                    ),
                  ),
                  Divider(
                    height: 20.0,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: FlatButton(
                        onPressed: () {
                          _signup(context);
                        },
                        color: Color.fromARGB(255, 229, 28, 85),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.android, color: Colors.white),
                            SizedBox(width: 20),
                            Text(
                              'SIGN UP with Google',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'FredokaOne',
                                  fontSize: 25.0),
                            )
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
