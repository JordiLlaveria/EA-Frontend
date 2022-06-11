import 'dart:html';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/widgets/icon_container.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  GlobalKey key = GlobalKey();
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  GlobalKey key3 = GlobalKey();

  @override
  void initState() {
    initTarget();
    WidgetsBinding.instance.addPostFrameCallback(_afterlayaout);
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
      colorShadow: Theme.of(context).cardColor,
      opacityShadow: 0.95,
    )..show();
  }

  void initTarget() {
    targets.clear();
    targets.add(
      TargetFocus(
          identify: "key1",
          keyTarget: key1,
          alignSkip:
              Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.12),
          paddingFocus: 0,
          contents: [
            TargetContent(
                child: Container(
              child: Column(
                children: [
                  Text(
                    "DO YOU HAVE AN ACOUNT ALREADY? SIGN IN! CLICK ON LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ))
          ]),
    );
    targets.add(
      TargetFocus(
          identify: "key2",
          keyTarget: key2,
          alignSkip:
              Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.12),
          paddingFocus: 0,
          contents: [
            TargetContent(
                child: Container(
              child: Column(
                children: [
                  Text(
                    "ARE YOU NEW IN XERRA? SIGN UP! CLICK ON REGISTER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ))
          ]),
    );
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
                    key: key1,
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
                    key: key2,
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
