import 'package:flutter/material.dart';
import 'package:frontend/screens/index_screen.dart';

class LogoutForm extends StatefulWidget {
  LogoutForm({Key? key}) : super(key: key);

  @override
  State<LogoutForm> createState() => _LogoutFormState();
}

class _LogoutFormState extends State<LogoutForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            final route = MaterialPageRoute(
                            builder: (context) => IndexScreen()); //Canviar a Signup
                        Navigator.push(context, route);
          },
          color: Colors.yellow,
          child: Text('LOGOUT', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}