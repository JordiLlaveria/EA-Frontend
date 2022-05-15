import 'package:flutter/material.dart';
import 'package:frontend/screens/register_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Grup 1',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const RegisterScreen(),
    );
  }
}