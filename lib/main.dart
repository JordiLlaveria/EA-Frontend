import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/index_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDuemCj0-z6L-7gSsTfLrTWvRCz4EJwIt0",
          authDomain: "flutter-ea-7aa08.firebaseapp.com",
          projectId: "flutter-ea-7aa08",
          storageBucket: "flutter-ea-7aa08.appspot.com",
          messagingSenderId: "170890857564",
          appId: "1:170890857564:web:df7b485150e8a6a0c32a99"));

  runApp(MyApp());
}

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
        'Home': (BuildContext context) => IndexScreen(),
        'Login': (BuildContext context) => LoginScreen(),
        'Register': (BuildContext context) =>
            RegisterScreen() //Canviar a SIGNUP
      },
    );
  }
}
