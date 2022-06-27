import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import '../models/activities_model.dart';
import '../models/user_model.dart';

import 'package:intl/intl.dart';

class AddActivityScreen extends StatefulWidget {
  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  static String organizerId = LocalStorage('Users').getItem('userID');
  static String username = LocalStorage('Users').getItem('username');
  static String token = LocalStorage('Users').getItem('token').toString();

  late Activity newActivity;
  final TextEditingController nameAct = TextEditingController();
  final TextEditingController descriptionAct = TextEditingController();
  final TextEditingController dateAct = TextEditingController();
  final TextEditingController lonAct = TextEditingController();
  final TextEditingController latAct = TextEditingController();
  static bool accessible = false;
  final TextEditingController languageAct = TextEditingController();

  void initState() {
    super.initState();
  }

  Future<void> addActivity(String name, String description, String language,
      String latitude, String longitude, String date, bool accessible) async {
    var dateFormatted = DateTime.parse(date);

    List<String> locationFormat = [];
    locationFormat.add(latitude);
    locationFormat.add(longitude);

    var newActivity = await ActivityService.addActivity(name, description,
        organizerId, language, locationFormat, date, accessible, token);
    //return newActivity;
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
            body: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: buildForm())));
  }

  /*Column buildFormOld() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: nameAct,
          decoration: const InputDecoration(hintText: 'Enter Activity Name'),
        ),
        ElevatedButton(
          onPressed: () {
            addActivity(nameAct.text, description, organizerId, language,
                location, date);
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }*/

  Column buildForm() {
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
                        decoration: const InputDecoration(
                          hintText: 'Enter Activity Name',
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
                        decoration: const InputDecoration(
                          hintText: 'Enter Description',
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
                        decoration: const InputDecoration(
                          hintText: 'Enter Language',
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
                        decoration: const InputDecoration(
                          hintText: 'Enter Longitude',
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
                        decoration: const InputDecoration(
                          hintText: 'Enter Latitude',
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
                        decoration: const InputDecoration(
                          hintText: 'Enter Date   (2023-01-23)',
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
                    addActivity(
                        nameAct.text,
                        descriptionAct.text,
                        languageAct.text,
                        latAct.text,
                        lonAct.text,
                        dateAct.text,
                        accessible);
                    setState(() {});
                    final route = MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(username: username)); //Canviar a Signup
                    Navigator.push(context, route);
                  },
                  child: const Text('Create Activity'),
                ),
              ]))
    ]);
  }
}
