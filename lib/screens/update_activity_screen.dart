import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/screens/user_activities.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import '../models/activities_model.dart';
import '../models/user_model.dart';

import 'package:intl/intl.dart';

import 'add_activity_screen.dart';

class UpdateActivityScreen extends StatefulWidget {
  final String activityName;

  const UpdateActivityScreen({required this.activityName});

  @override
  _UpdateActivityScreenState createState() => _UpdateActivityScreenState();
}

class _UpdateActivityScreenState extends State<UpdateActivityScreen> {
  static String token = LocalStorage('Users').getItem('token');
  static String organizerId = LocalStorage('Users').getItem('userID');

  late Activity activity;
  final TextEditingController nameAct = TextEditingController();
  final TextEditingController descriptionAct = TextEditingController();
  final TextEditingController dateAct = TextEditingController();
  final TextEditingController lonAct = TextEditingController();
  final TextEditingController latAct = TextEditingController();
  final TextEditingController languageAct = TextEditingController();

  void initState() {
    super.initState();
  }

  Future<Activity> getActivity(String name) async {
    activity = await ActivityService.getActivity(widget.activityName);
    return activity;
  }

  Future<void> updateActivity(String id, String name, String description,
      String language, String latitude, String longitude, String date) async {
    var dateFormatted = DateTime.parse(date);

    List<String> locationFormat = [];
    locationFormat.add(latitude);
    locationFormat.add(longitude);

    var newActivity = await ActivityService.updateActivity(
        id, name, description, language, locationFormat, date, token);
  }

  @override
  Widget build(BuildContext context) {
    return
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
                            children: <Widget>[buildForm(activity)]))
                    : Center(
                        child: CircularProgressIndicator(),
                      )));
  }

  Column buildForm(Activity activity) {
    return Column(children: [
      Container(
          padding: EdgeInsets.fromLTRB(50, 25, 20, 25),
          width: double.maxFinite,
          child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: 20),
                Container(
                    child: TextField(
                        controller: nameAct,
                        decoration: new InputDecoration(
                          hintText: activity.name,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(234, 80, 80, 80)
                                  //Color.fromARGB(255, 192, 62, 68)
                                  )),
                          prefixIcon: const Icon(Icons.textsms_sharp,
                              color: Color.fromARGB(255, 192, 62, 68)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 192, 62, 68),
                                  width: 2)),
                        ))),
                SizedBox(height: 20),
                Container(
                    child: TextField(
                        controller: descriptionAct,
                        decoration: new InputDecoration(
                          hintText: activity.description,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(234, 80, 80, 80)
                                  //Color.fromARGB(255, 192, 62, 68)
                                  )),
                          prefixIcon: const Icon(Icons.textsms_sharp,
                              color: Color.fromARGB(255, 192, 62, 68)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 192, 62, 68),
                                  width: 2)),
                        ))),
                SizedBox(height: 20),
                Container(
                    child: TextField(
                        controller: languageAct,
                        decoration: new InputDecoration(
                          hintText: activity.language,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(234, 80, 80, 80)
                                  //Color.fromARGB(255, 192, 62, 68)
                                  )),
                          prefixIcon: const Icon(Icons.textsms_sharp,
                              color: Color.fromARGB(255, 192, 62, 68)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 192, 62, 68),
                                  width: 2)),
                        ))),
                SizedBox(height: 20),
                Container(
                    child: TextField(
                        controller: lonAct,
                        decoration: new InputDecoration(
                          hintText: activity.location.coordinates[0],
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(234, 80, 80, 80)
                                  //Color.fromARGB(255, 192, 62, 68)
                                  )),
                          prefixIcon: const Icon(Icons.textsms_sharp,
                              color: Color.fromARGB(255, 192, 62, 68)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 192, 62, 68),
                                  width: 2)),
                        ))),
                SizedBox(height: 20),
                Container(
                    child: TextField(
                        controller: latAct,
                        decoration: new InputDecoration(
                          hintText: activity.location.coordinates[1],
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(234, 80, 80, 80)
                                  //Color.fromARGB(255, 192, 62, 68)
                                  )),
                          prefixIcon: const Icon(Icons.textsms_sharp,
                              color: Color.fromARGB(255, 192, 62, 68)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 192, 62, 68),
                                  width: 2)),
                        ))),
                SizedBox(height: 20),
                Container(
                    child: TextField(
                        controller: dateAct,
                        decoration: new InputDecoration(
                          hintText: getDate(activity),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(234, 80, 80, 80)
                                  //Color.fromARGB(255, 192, 62, 68)
                                  )),
                          prefixIcon: const Icon(Icons.textsms_sharp,
                              color: Color.fromARGB(255, 192, 62, 68)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 192, 62, 68),
                                  width: 2)),
                        ))),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 192, 62, 68),
                    padding: EdgeInsets.all(6.0),
                  ),
                  onPressed: () {
                    print('pressed');
                    String nameUp, desUp, lanUp, latUp, lonUp, dateUp;

                    if (nameAct.text == '') {
                      nameUp = activity.name;
                    } else {
                      nameUp = nameAct.text;
                    }

                    if (descriptionAct.text == '')
                      desUp = activity.description;
                    else
                      desUp = descriptionAct.text;

                    print('nameAct' + descriptionAct.text);
                    print('nameUp' + desUp);
                    print('activityName' + activity.description);
                    if (languageAct.text == '')
                      lanUp = activity.language;
                    else
                      lanUp = languageAct.text;

                    if (latAct.text == '')
                      latUp = activity.location.coordinates[0];
                    else
                      latUp = latAct.text;

                    if (lonAct.text == '')
                      lonUp = activity.location.coordinates[1];
                    else
                      lonUp = lonAct.text;

                    if (dateAct.text == '')
                      dateUp = getDate(activity);
                    else
                      dateUp = dateAct.text;

                    print(nameUp + desUp + lanUp + latUp + lonUp + dateUp);

                    updateActivity(activity.id, nameUp, desUp, lanUp, latUp,
                        lonUp, dateUp);

                    //setState(() {});
                    final route = MaterialPageRoute(
                        builder: (context) =>
                            UserActivities()); //Canviar a Signup
                    Navigator.push(context, route);
                  },
                  child: const Text('Update Activity'),
                ),
              ]))
    ]);
  }
}

String getDate(Activity activity) {
  DateTime date = DateTime.parse(activity.date);
  String dateF = date.year.toString() +
      '-' +
      date.month.toString() +
      '-' +
      date.day.toString();
  var newDt = DateFormat.yMd().format(date);
  return dateF;
}
