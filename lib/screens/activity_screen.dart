import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/services/activity_service.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/cupertino.dart';
import '../models/activities_model.dart';

class ActivityScreen extends StatefulWidget {
  final String activityName;

  const ActivityScreen({
    required this.activityName,
  });

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  ActivityService activityService = ActivityService();
  String locations = "";
  late Activity activity;

  void initState() {
    super.initState();
  }

  Future<Activity> getActivity(String name) async {
    activity = await ActivityService.getActivity(widget.activityName);
    print('ACTIVITY loaded');
    return activity;
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
                        children: <Widget>[
                          _activity(activity),
                        ],
                      ))
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
              },
              label: const Text('Join Activity'),
              icon: const Icon(Icons.add),
              backgroundColor: Color.fromARGB(255, 192, 62, 68),
            )));
  }
}

Widget _activity(Activity activity) {
  return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
      width: double.maxFinite,
      child: Column(children: [
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
            SizedBox(width: 25, height: 40),
            Text(activity.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  //fontWeight: FontWeight.bold,
                  color: Colors.black,
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
            SizedBox(width: 25, height: 40),
            Text('Language: ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            Text(activity.language,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  //fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))
          ],
        ),
        Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Icon(Icons.person, color: Color.fromARGB(234, 80, 80, 80)),
            ),
            SizedBox(width: 25, height: 40),
            Text('Organizer: ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            Text(activity.organizer['username'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  //fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))
          ],
        ),
        Row(
          children: [
            SizedBox(
                height: 30,
                width: 30,
                child:
                    Icon(Icons.people, color: Color.fromARGB(234, 80, 80, 80))),
            SizedBox(width: 25, height: 40),
            Text('Participants: ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))
            //_userList(activity)
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
              height: 30,
              width: 30,
              child: Icon(Icons.map_outlined,
                  color: Color.fromARGB(234, 80, 80, 80))),
          SizedBox(width: 25, height: 40),
          Column(children: [
            Text('Location: ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            // _Map(activity)
          ])
        ]),
      ]));
}
/*
Widget _Map(Activity activity) {
  return Container(
    height: 500,
    width: 300,
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
                      color: Colors.red,
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
*/

/*Widget _userList(Activity activity) {
  return Expanded(
      child: ListView.builder(
// scrollDirection: Axis.horizontal,
          itemCount: activity.users?.length,
          itemBuilder: (context, index) {
            return Text(activity.users?[index]['username']);
          }));
}*/

Widget loadingWidget() {
  return const CircularProgressIndicator();
}
