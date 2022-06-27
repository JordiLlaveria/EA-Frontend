import 'dart:convert';
import 'dart:html';
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

  static bool accessible = false;

  void initState() {
    super.initState();
  }

  Future<Activity> getActivity(String name) async {
    activity = await ActivityService.getActivity(widget.activityName);
    return activity;
  }

  Future<void> updateActivity(
      String id,
      String name,
      String description,
      String language,
      String latitude,
      String longitude,
      bool accessible,
      String date) async {
    var dateFormatted = DateTime.parse(date);

    List<String> locationFormat = [];
    locationFormat.add(latitude);
    locationFormat.add(longitude);

    print(id);
    print(description);
    print(organizerId);
    print(language);
    print(locationFormat.toString());
    print(date);
    print(accessible);
    print(token);

    var newActivity = await ActivityService.updateActivity(
        id,
        name,
        description,
        organizerId,
        language,
        locationFormat,
        date,
        accessible,
        token);
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
                          hintText: activity.location.coordinates[0].toString(),
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
                          hintText: activity.location.coordinates[1].toString(),
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
                Row(
                  children: [
                    Text('Accessibility: ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 85, 85, 85),
                        )),
                    SizedBox(width: 20),
                    Container(
                        child: Checkbox(
                      checkColor: Colors.white,
                      value: accessible,
                      onChanged: (bool? value) {
                        setState(() {
                          accessible = value!;
                        });
                      },
                    )),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 192, 62, 68),
                    padding: EdgeInsets.all(6.0),
                  ),
                  onPressed: () {
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

                    if (languageAct.text == '')
                      lanUp = activity.language;
                    else
                      lanUp = languageAct.text;

                    if (latAct.text == '')
                      latUp = activity.location.coordinates[0].toString();
                    else
                      latUp = latAct.text;

                    if (lonAct.text == '')
                      lonUp = activity.location.coordinates[1].toString();
                    else
                      lonUp = lonAct.text;

                    if (dateAct.text == '')
                      dateUp = getDate(activity);
                    else
                      dateUp = dateAct.text;

                    print(nameUp + desUp + lanUp + latUp + lonUp + dateUp);
                    print(activity.id.toString());

                    updateActivity(activity.id.toString(), nameUp, desUp, lanUp,
                        latUp, lonUp, accessible, dateUp);

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
  String month, day;

  if (date.month.toString().length == 1)
    month = '0' + date.month.toString();
  else
    month = date.month.toString();
  if (date.day.toString().length == 1)
    day = '0' + date.day.toString();
  else
    day = date.month.toString();

  String dateF = date.year.toString() + '-' + month + '-' + day;
  var newDt = DateFormat.yMd().format(date);
  return dateF;
}
