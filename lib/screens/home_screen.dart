import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:frontend/services/activity_service.dart';
import '../models/activities_model.dart';

import 'package:frontend/services/user_service.dart';
import '../models/activities_model.dart';
import '../models/user_model.dart';
import 'activity_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ActivityService activityService = ActivityService();
  List<Activity> activities = [];
  bool _isLoading = true;
  late String name;
  String locations = "";
  bool viewMode = true;

  void initState() {
    super.initState();
    getActivities();
  }

  Future<void> getActivities() async {
    activities = await ActivityService.getActivities();
    setState(() {
      _isLoading = false;
    });

    print(activities);
    print(activities[0].organizer);
  }

  void toggle() {
    setState(() => viewMode = !viewMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _topBar(viewMode, toggle),
                  viewMode ? _activityList(activities, locations) : _mapList(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
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

Widget _activityList(List<Activity> activities, String locations) {
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
                                                    234, 80, 80, 80),
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
                                          Text(activities[index].language,
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
                                          Text(
                                              locations = GetLocations(
                                                activities[index].location.coordinates,
                                              ),
                                              semanticsLabel: '${locations}',
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
                                          Text(
                                              'Organized by: ' +
                                                  activities[index]
                                                      .organizer['username'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.italic)),
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
                                              activityName: activities[index]
                                                  .name)); //Canviar a Signup
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

Widget _topBar(bool viewMode, toggle) {
  return Container(
      height: 60,
      width: double.maxFinite,
      color: Color.fromARGB(166, 211, 62, 59),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
        ],
      ));
}

Widget _mapList() {
  return Container(
    child: Text('MAP'),
  );
}
