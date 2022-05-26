import 'package:flutter/material.dart';
import 'package:frontend/screens/index_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/screens/login_screen.dart';

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
      initialRoute: 'Index',
      routes: <String, WidgetBuilder>{
        'Index': (BuildContext context) => IndexScreen(),
        'Login': (BuildContext context) => LoginScreen(),
        'Register': (BuildContext context) => RegisterScreen()
      },
    );
  }
}