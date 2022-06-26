import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../widgets/icon_container.dart';
import '../widgets/register_form.dart';
import 'app_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey keyName = GlobalKey();
  GlobalKey keyWelcome = GlobalKey();
  GlobalKey keyUsername = GlobalKey();
  GlobalKey keyLanguages = GlobalKey();
  GlobalKey keyButton = GlobalKey();

  List<TargetFocus> targets = <TargetFocus>[];

  late TutorialCoachMark tutorialCoachMark;

  void initState() {
    initTarget();
    WidgetsBinding.instance?.addPostFrameCallback(_afterlayaout);
    super.initState();
  }

  void _afterlayaout(_) {
    Future.delayed(Duration(milliseconds: 100));
    showTutorial();
  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      alignSkip: Alignment.topRight,
      colorShadow: Theme.of(context).cardColor,
      opacityShadow: 0.95,
    )..show();
  }

  void initTarget() {
    targets.add(TargetFocus(
        identify: "Welcome",
        keyTarget: keyWelcome,
        shape: ShapeLightFocus.Circle,
        enableOverlayTab: true,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "WELCOME TO THE REGISTER SCREEN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 30.0,
                          fontFamily: 'FredokaOne'),
                    ),
                    Text(
                      "In this screen you can create your user. You only need to fill the following form.",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ]));
    targets.add(TargetFocus(
        identify: "Name",
        keyTarget: keyName,
        shape: ShapeLightFocus.RRect,
        radius: 20,
        enableOverlayTab: true,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "First write your data: name, surname, email and phone.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ]));
    targets.add(TargetFocus(
        identify: "Username",
        keyTarget: keyUsername,
        shape: ShapeLightFocus.RRect,
        radius: 20,
        enableOverlayTab: true,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Then you can choose a username and a password. Repeat the password to be sure you wrote it correctly",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ]));
    targets.add(TargetFocus(
        identify: "Languages",
        keyTarget: keyLanguages,
        shape: ShapeLightFocus.RRect,
        radius: 20,
        enableOverlayTab: true,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Choose the languages you speak and your profile picture.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ]));
    targets.add(TargetFocus(
        identify: "Button",
        keyTarget: keyLanguages,
        shape: ShapeLightFocus.RRect,
        radius: 20,
        enableOverlayTab: true,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Finally when you're done click this button to finish the registration process.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ]));
  }

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
                      key: keyWelcome,
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
                            'SIGN UP',
                            style: TextStyle(
                                fontSize: 30.0, fontFamily: 'FredokaOne'),
                          ),
                        ],
                      )),
                  Divider(
                    height: 10.0,
                  ),
                  RegisterForm(keyName: keyName, keyUsername: keyUsername, keyLanguages: keyLanguages, keyButton: keyButton,),
                ],
              )
            ],
          ),
        ),       
      ),
    );
  }
}
