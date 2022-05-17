import 'package:flutter/material.dart';
import 'package:frontend/screens/Index_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/screens/sign_in.dart';
//import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/screens/sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LogIn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'Home',
      routes: <String, WidgetBuilder>{
        'Home': (BuildContext context) => Index(),
        'SignIn': (BuildContext context) => SignIn(),
        'SignUp': (BuildContext context) => RegisterScreen() //Canviar a SIGNUP
      },
    );
  }
}
