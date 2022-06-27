import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:frontend/screens/user_activities.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:localstorage/localstorage.dart';
import '../models/activities_model.dart';

import 'package:frontend/services/user_service.dart';
import '../models/activities_model.dart';
import '../models/user_model.dart';
import 'activity_screen.dart';
import 'add_activity_screen.dart';
import 'home_screen.dart';

class PastActivities extends StatefulWidget {
  const PastActivities();

  @override
  _PastActivitiesState createState() => _PastActivitiesState();
}

class _PastActivitiesState extends State<PastActivities> {
  String username = LocalStorage('Users').getItem('username');
  String idUser = LocalStorage('Users').getItem('userID');

  List<Activity> activities = [];
  bool _isLoading = true;
  late String name;
  String locations = "";
  bool viewMode = true;

  void initState() {
    super.initState();
    getActivitiesByDate();
  }

  Future<void> getActivitiesByDate() async {
    activities = await ActivityService.getActivitiesByDate();

    setState(() {
      _isLoading = false;
    });
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        var newPage = MaterialPageRoute(
            builder: (context) =>
                HomeScreen(username: username)); //Canviar a Signup
        Navigator.push(context, newPage);
        break;
      case 1:
        var newPage = MaterialPageRoute(
            builder: (context) => UserActivities()); //Canviar a Signup
        Navigator.push(context, newPage);
        break;
      case 2:
        setState(() {});

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(166, 211, 62, 59),
              title: Text(
                "Activity Archive",
                style: TextStyle(color: Colors.black),
              ),
              leading: Container(
                child: PopupMenuButton<int>(
                    icon: Icon(Icons.menu, color: Colors.black),
                    padding: const EdgeInsets.all(15.0),
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) => [
                          PopupMenuItem<int>(
                              value: 0,
                              child: Row(children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text('Activities')
                              ])),
                          PopupMenuItem<int>(
                              value: 1,
                              child: Row(children: [
                                Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text('Your Activities')
                              ])),
                          PopupMenuItem<int>(
                              value: 2,
                              child: Row(children: [
                                Icon(
                                  Icons.timer_sharp,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text('Activity Archive')
                              ])),
                        ]),
              )),
          body: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _activityList(activities, locations, username)
              ],
            ),
          ),
          bottomNavigationBar: _navigation(widget),
        ));
  }
}

String GetLocations(List<dynamic> locations) {
  String location = "";
  location = locations[0];
  for (var i = 1; i < locations.length; i++) {
    location = location + ", " + locations[i];
  }
  return location;
}

Widget _activityList(
    List<Activity> activities, String locations, String username) {
  return Expanded(
      child: ListView.builder(
// scrollDirection: Axis.horizontal,
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                height: 220,
                width: double.maxFinite,
                child: Card(
                    elevation: 0,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(
                                color: Color.fromARGB(234, 80, 80, 80),
                                width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Stack(children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(activities[index].name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 192, 62, 68),
                                              )),
                                          SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(activities[index].description,
                                              style: TextStyle(
                                                fontSize: 18,
                                              )),
                                          SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromARGB(
                                                    166, 211, 62, 59),
                                              ),
                                              child: Text(
                                                  activities[index].language,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(255,
                                                          255, 255, 255)))),
                                          SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text('Organized by: ',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.italic)),
                                          Text(
                                              activities[index]
                                                  .organizer['username'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 192, 62, 68))),
                                          SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: FloatingActionButton(
                                    heroTag: null,
                                    backgroundColor:
                                        Color.fromARGB(255, 192, 62, 68),
                                    onPressed: () {
                                      final route = MaterialPageRoute(
                                          builder: (context) => ActivityScreen(
                                              activityName:
                                                  activities[index].name,
                                              username:
                                                  username)); //Canviar a Signup
                                      Navigator.push(context, route);
                                    },
                                    mini: true,
                                    child: const Icon(Icons.add, size: 20)),
                              ),
                            ),
                          ]),
                        ))));
          }));
}

Widget _mapList() {
  return Container(
    child: Text('MAP'),
  );
}

_navigation(widget) {
  int currentScreen = 0;

  return BottomNavigationBar(
    currentIndex: currentScreen,
    onTap: (index) {
      widget.setState(() {
        currentScreen = index;
      });
    },
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.black.withOpacity(0.5),
    selectedItemColor: Colors.blue,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: 'Home',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: 'Chat'),
      BottomNavigationBarItem(
          icon: Icon(Icons.people_rounded), label: 'Search'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  );
}
