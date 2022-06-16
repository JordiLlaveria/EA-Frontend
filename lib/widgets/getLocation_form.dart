import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationForm extends StatefulWidget {
  LocationForm({Key? key}) : super(key: key);

  @override
  State<LocationForm> createState() => _LocationFormState();
}

void _getCurrentLocation() async{
  final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position);

}

class _LocationFormState extends State<LocationForm> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              FlatButton(
                onPressed: () {
                  _getCurrentLocation();
                }, 
                color: Colors.red,
                child: Text("Find my Location")
              )
            ],
          ),
        ),
      ),
    );
  }
}