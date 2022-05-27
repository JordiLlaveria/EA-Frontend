import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/login_form.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../widgets/icon_container.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  GlobalKey key = GlobalKey();
  GlobalKey key1 = GlobalKey();

  void initTargets(){
    targets.clear();
    targets.add(
      TargetFocus(
        identify: "key",
        keyTarget: key,
        alignSkip: Alignment.lerp(Alignment.bottomLeft, Alignment.bottomCenter, 0.12),
        paddingFocus: 0,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            padding: EdgeInsets.only(top: 300),
          )
        ]
      )
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
                  'SIGIN',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'FredokaOne'
                  ),
                ),
                Divider(
                  height: 10.0,
                ),
                //Formulari
                LoginForm()
              ],
            )
          ],
        ),
      ),
    ),
    );
  }
}