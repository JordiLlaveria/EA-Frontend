import 'package:flutter/material.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:frontend/screens/xat_screen.dart';
import 'package:frontend/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentScreen = 0;

  List<Widget> screens = [
    HomeScreen(),
    XatScreen(),
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
                  icon: Icon(Icons.chat_rounded), label: 'Xat'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_rounded), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ));
  }
}
