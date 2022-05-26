import 'package:flutter/material.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/chat_screen.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:localstorage/localstorage.dart';


class AppScreen extends StatefulWidget {
  /* const AppScreen({Key? key}) : super(key: key); */
  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int currentScreen = 0;

  /* static String username = LocalStorage('Users').getItem('username'); */

  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(username: "miguelmalu"),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Grup 1',
        home: Scaffold(
          body: screens[currentScreen],

          // Bottom Navigation Bar
          bottomNavigationBar: BottomNavigationBar(
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
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_rounded), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_rounded), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ));
  }
}
