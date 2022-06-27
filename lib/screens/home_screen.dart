import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/past_activities.dart';
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

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = LocalStorage('Users').getItem('username');
  List<Activity> activities = [];
  bool _isLoading = true;
  late String name;
  String locations = "";
  bool viewMode = true;
  var storage;

  void initState() {
    super.initState();
    getActivities();
  }

  Future<void> getActivities() async {
    activities = await ActivityService.getActivities();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getActivitiesByDistance() async {
    storage = LocalStorage('Users');
    await storage.ready;
    var id = storage.getItem('userID');
    activities = await ActivityService.getActivitiesByDistance("50000",id);
    
  }

  /*void toggle() {
    setState(() => viewMode = !viewMode);
  }*/

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setState(() {});
        break;
      case 1:
        final route = MaterialPageRoute(builder: (context) => UserActivities());
        Navigator.push(context, route);

        break;
      case 2:
        var route = MaterialPageRoute(builder: (context) => PastActivities());
        Navigator.push(context, route);
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
                "Xerra!",
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
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    color: Colors.black,
                    //hoverColor: Color.fromARGB(166, 211, 62, 59),
                    icon: Icon(Icons.note_add, size: 25, color: Colors.black),
                    onPressed: () {
                      final route = MaterialPageRoute(
                          builder: (context) =>
                              AddActivityScreen()); //Canviar a Signup
                      Navigator.push(context, route);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Row(
                      /* children: [
                      Text('MAP',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 192, 62, 68),
                          )),
                      Switch(
                          value: viewMode,
                          activeColor: Color.fromARGB(255, 192, 62, 68),
                          inactiveTrackColor: Color.fromARGB(255, 192, 62, 68),
                          onChanged: (val) {
                            toggle();
                          }),
                      Text('LIST',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 192, 62, 68),
                          )),
                    ],*/
                      ),
                ),
              ],
            ),
            body: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  viewMode
                      ? _activityList(activities, locations, username)
                      : _mapList(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
               
                setState(() {
                  getActivitiesByDistance(); 
                   build(context);                 
                });                
              },
              //label: const Text(''),
              child: const Icon(Icons.filter_alt),
              backgroundColor: Color.fromARGB(255, 192, 62, 68),
            )));
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
