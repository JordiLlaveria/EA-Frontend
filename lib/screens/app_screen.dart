import 'package:flutter/material.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/chat_screen.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/chatbot_screen.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


class AppScreen extends StatefulWidget {
  /* const AppScreen({Key? key}) : super(key: key); */
  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int currentScreen = 0;

  static String username = LocalStorage('Users').getItem('username');

  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(username: username),
    ChatbotScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  GlobalKey keyHome = GlobalKey();
  GlobalKey keyChat = GlobalKey();
  GlobalKey keySearch = GlobalKey();
  GlobalKey keyProfile = GlobalKey();
  GlobalKey keyNavigation = GlobalKey();

  List<TargetFocus> targets = <TargetFocus>[];

    late TutorialCoachMark tutorialCoachMark;

    void initState(){
      initTarget();
      WidgetsBinding.instance?.addPostFrameCallback(_afterlayaout);
      super.initState();
    }

    void _afterlayaout (_){
      Future.delayed(Duration(milliseconds:100));
      showTutorial();
    }

    void showTutorial(){
      tutorialCoachMark = TutorialCoachMark(
        context,
        targets: targets,
        alignSkip: Alignment.topRight,
        colorShadow: Theme.of(context).cardColor,
        opacityShadow: 0.95, 
      )..show();
    }

    void initTarget(){
      targets.add(
        TargetFocus(
            identify: "Navigation",
            keyTarget: keyNavigation,
            shape: ShapeLightFocus.RRect,
            radius: 20,
            enableOverlayTab: true,
            contents: [
              TargetContent(
                  align: ContentAlign.top,
                  child: Container(
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "WELCOME TO XERRA",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 30.0,
                            fontFamily: 'FredokaOne'                            
                          ),
                        ),
                        Text("With the bottom bar you can navigate through the app.",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20,
                            ),),
                      ],
                    ),
                  )
              )
            ]
        )
    );
    
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Grup 1',
        home: Scaffold(
          body: screens[currentScreen],

          // Bottom Navigation Bar
          bottomNavigationBar: BottomNavigationBar(
            key: keyNavigation,
            currentIndex: currentScreen,
            onTap: (index) {
              setState(() {
                currentScreen = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.black.withOpacity(0.5),
            selectedItemColor: Colors.blue,
            items: [
              BottomNavigationBarItem(                                  
                  icon: Icon(Icons.home_filled), label: 'Home',),
              BottomNavigationBarItem(                  
                  icon: Icon(Icons.chat_rounded), label: 'Chat'),
              BottomNavigationBarItem(                  
                  icon: Icon(Icons.help_rounded), label: 'Chatbot'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_rounded), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ));
  }
}
