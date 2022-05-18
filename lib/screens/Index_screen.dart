//import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/widgets/icon_container.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({ Key? key }) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
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
                  'PROJECTE EA: XERRA',
                  style: TextStyle(
                    fontFamily: 'FredokaOne',
                    fontSize: 30.0
                  ),
                ),
                Text(
                  '[GRUP 1]',
                  style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    fontSize: 18.0
                  ) ,
                ),
                Divider(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60.0,
                  child: FlatButton(
                    onPressed: (){
                      final route = MaterialPageRoute(
                        builder: (context) => LoginScreen());
                      Navigator.push(context, route);
                    },
                    color: Color.fromARGB(255, 226, 174, 15),
                    child: Text('SIGN IN',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FredokaOne',
                      fontSize: 30.0
                    ), 
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
                    onPressed: (){
                      final route = MaterialPageRoute(
                        builder: (context) => RegisterScreen()); //Canviar a Signup
                      Navigator.push(context, route);
                    },
                    color: Color.fromARGB(255, 229, 28, 85),
                    child: Text('SIGN UP',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FredokaOne',
                      fontSize: 30.0
                    ), 
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
}