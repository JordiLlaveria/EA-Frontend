import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import '../models/activities_model.dart';
import '../models/user_model.dart';

import 'package:intl/intl.dart';

class ActivityScreen extends StatefulWidget {
  final String activityName;
  final String username;

  const ActivityScreen({required this.activityName, required this.username});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String username = LocalStorage('Users').getItem('username');
  String idUser = LocalStorage('Users').getItem('userID');
  bool joinActivity = false;
  ActivityService activityService = ActivityService();
  String locations = "";
  late Activity activity;

  void initState() {
    super.initState();
  }

  Future<Activity> getActivity(String name) async {
    activity = await ActivityService.getActivity(widget.activityName);

    return activity;
  }

  Future<bool> addUserToActivity(String idUser, String idActivity) async {
    joinActivity = await ActivityService.addUserToActivity(idUser, idActivity);

    print(idUser);
    print(idActivity);

    return joinActivity;
  }

  @override
  Widget build(BuildContext context) {
    return (
        //debugShowCheckedModeBanner: false,
        Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(166, 211, 62, 59),
              //leading: Icon(Icons.arrow_back),
              //automaticallyImplyLeading: true,
            ),
            body: FutureBuilder(
                future: getActivity(widget.activityName),
                builder: (context, AsyncSnapshot snapshot) => snapshot.hasData
                    ? Container(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[_activity(activity)]))
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                addUserToActivity(idUser, activity.id);
                setState(() {});

                // Falten Alerts
              },
              label: const Text('Join Activity'),
              icon: const Icon(Icons.add),
              backgroundColor: Color.fromARGB(255, 192, 62, 68),
            )));
  }
}

Widget _activity(Activity activity) {
  return Expanded(
      child: Container(
          padding: EdgeInsets.fromLTRB(50, 25, 20, 25),
          width: double.maxFinite,
          child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Column(children: [
                  Text(activity.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 192, 62, 68),
                      )),
                  Row(
                    children: [
                      SizedBox(height: 30, width: 30, child: Icon(Icons.list)),
                      SizedBox(width: 25, height: 60),
                      Text(activity.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromARGB(234, 80, 80, 80),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(Icons.chat_bubble,
                              color: Color.fromARGB(234, 80, 80, 80))),
                      SizedBox(width: 25, height: 60),
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(166, 211, 62, 59),
                          ),
                          child: Text(activity.language,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Color.fromARGB(255, 255, 255, 255)))),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(Icons.person,
                            color: Color.fromARGB(234, 80, 80, 80)),
                      ),
                      SizedBox(width: 25, height: 60),
                      Text('Organized by:  ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          )),
                      Text(activity.organizer['username'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 192, 62, 68),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(Icons.calendar_month_outlined,
                            color: Color.fromARGB(234, 80, 80, 80)),
                      ),
                      SizedBox(width: 25, height: 60),
                      Text(getDate(activity),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 192, 62, 68),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(Icons.people,
                              color: Color.fromARGB(234, 80, 80, 80))),
                      SizedBox(width: 25, height: 60),
                      Text('Participants: ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      _userList(activity.users),
                      SizedBox(width: 25, height: 60)
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Column(children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.map_outlined,
                            color: Color.fromARGB(234, 80, 80, 80),
                          ))
                    ]),
                  ]),
                  Row(children: [
                    Column(children: [_Map(activity)])
                  ])
                ])
              ])));
}

Widget _Map(Activity activity) {
  return Container(
    alignment: Alignment.center,
    height: 250,
    width: 150,
    margin: const EdgeInsets.only(left: 60),
    child: new FlutterMap(
      options: new MapOptions(
        //center: new LatLng(41.441392, 2.186303), //AQUI!!
        center: new LatLng(double.parse(activity.location[0]),
            double.parse(activity.location[1])), //AQUI!!
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return Text("© OpenStreetMap contributors");
          },
        ),
        new MarkerLayerOptions(markers: [
          Marker(
              width: 80.0,
              height: 80.0,
              point: new LatLng(double.parse(activity.location[0]),
                  double.parse(activity.location[1])), //AQUÍ!!
              builder: (context) => new Container(
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Color.fromARGB(255, 192, 62, 68),
                      iconSize: 45.0,
                      onPressed: () {
                        print('Marker tapped');
                      },
                    ),
                  ))
        ])
      ],
    ),
  );
}

Widget _userList(List<dynamic> users) {
  return Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 60),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Text(users[index]['username'],
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(234, 80, 80, 80),
                          ));
                    })
              ],
            ),
          )));
}

Widget loadingWidget() {
  return const CircularProgressIndicator();
}

String getDate(Activity activity) {
  DateTime date = DateTime.parse(activity.date);
  var newDt = DateFormat.yMMMEd().format(date);
  print(newDt);
  return newDt;
}
