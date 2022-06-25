import 'package:flutter/material.dart';
import '../widgets/register_google_form.dart';

class RegisterGoogleScreen extends StatefulWidget {
  final String? name;
  final String? surname;
  final String? username;
  final String? photo;
  final String? email;
  RegisterGoogleScreen(
      {Key? key,
      required this.name,
      required this.surname,
      required this.username,
      required this.email,
      required this.photo})
      : super(key: key);

  @override
  State<RegisterGoogleScreen> createState() => _RegisterGoogleScreenState(
      name: name,
      surname: surname,
      username: username,
      photo: photo,
      email: email);
}

class _RegisterGoogleScreenState extends State<RegisterGoogleScreen> {
  @override
  String? name;
  String? surname;
  String? username;
  String? photo;
  String? email;
  _RegisterGoogleScreenState(
      {required this.name,
      required this.surname,
      required this.username,
      required this.photo,
      required this.email});

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
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Column(
                    children: [
                      Container(
                        width: 100.0,
                        height: 110.0,
                        child: CircleAvatar(
                          radius: 200.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('imatges/Logo.PNG'),
                          //Definixo la ruta de la imatge en 'pubspex.yaml'
                        ),
                      ),
                      Text(
                        'SIGN UP with Google',
                        style:
                            TextStyle(fontSize: 30.0, fontFamily: 'FredokaOne'),
                      ),
                    ],
                  )),
                  Divider(
                    height: 10.0,
                  ),
                  RegisterGoogleForm(
                      name: name,
                      surname: surname,
                      username: username,
                      photo: photo,
                      email: email)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
