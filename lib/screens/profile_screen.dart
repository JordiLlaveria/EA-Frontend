import 'package:flutter/material.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/login_form.dart';
import 'package:frontend/widgets/map_form.dart';
import 'package:frontend/widgets/logout_form.dart';
import 'package:frontend/screens/index_screen.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../widgets/icon_container.dart';
import '../widgets/profile_form.dart';
import 'app_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late Future<bool> tutorial;

  List<TargetFocus> targets = <TargetFocus>[];

  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyWelcome = GlobalKey();
  GlobalKey keyLogout = GlobalKey();

  var storage;

  void initState() {  
    initTarget();    
    WidgetsBinding.instance?.addPostFrameCallback(_afterlayaout);
    super.initState();
  }


  void _afterlayaout(_) {
    Future.delayed(Duration(milliseconds: 100));
    showTutorial();
  }

   void showTutorial() async {
    storage = LocalStorage('Tutorial');
    await storage.ready;
    if(storage.getItem('profile') == true){      
      storage.setItem('profile', false);
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      alignSkip: Alignment.topRight,
      colorShadow: Theme.of(context).cardColor,
      opacityShadow: 0.95,
      
    )..show();   
    
    }
  }

  void initTarget(){
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
                      "WELCOME TO THE PROFILE SCREEN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 30.0,
                          fontFamily: 'FredokaOne'),
                    ),
                    Text(
                      "Here you can see your data",
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
        identify: "Logout",
        keyTarget: keyLogout,
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
                      "LOG OUT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 30.0,
                          fontFamily: 'FredokaOne'),
                    ),                   
                    Text(
                      "With the Logout button you can exit your account and return to the sign up screen.",
                      style: TextStyle(
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
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromARGB(255, 252, 252, 252),
                Color.fromARGB(255, 255, 255, 255)
              ],
              begin: Alignment.topCenter
            )
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 20
            ),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                    width: 80,
                    child:IconContainer(
                  url: 'imatges/Logo.PNG'
                  ),
                  ),
                  
                  Text(
                    'PROFILE',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'FredokaOne'
                    ),
                  ),
                  Divider(
                    height: 10.0,
                  ),
                               
                ],
              ),
              Container(
                key: keyWelcome,
                child: ProfileForm()
              ),
              
              Divider(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 320,
                child: MapForm(), 
              ),
              Divider(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: LogoutForm(buttonKey: keyLogout),
              ),
            ],
          ),
        ),       
    );
  }  
}