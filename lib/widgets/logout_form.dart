import 'package:flutter/material.dart';
import 'package:frontend/screens/index_screen.dart';

import '../helper/preferences_helper.dart';

class LogoutForm extends StatefulWidget {
  GlobalKey buttonKey;
  LogoutForm({Key? key, required this.buttonKey}) : super(key: key);

  @override
  State<LogoutForm> createState() => _LogoutFormState();
}

class _LogoutFormState extends State<LogoutForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          key: widget.buttonKey,
          onPressed: () async {
            await SharedPreferencesHelper.shared.removeToken();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const IndexScreen()),
                (route) => false);
          },
          color: Color.fromARGB(255, 214, 214, 214),
          child: Text('LOGOUT', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}