import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/user_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:localstorage/localstorage.dart';

class MapForm extends StatefulWidget {
  const MapForm({Key? key}) : super(key: key);
  @override
  State<MapForm> createState() => _MapFormState();
}

class _MapFormState extends State<MapForm> {
  UserService service = UserService();
  GlobalKey<FormState> _formkey = GlobalKey();

  late String name;
  late String surname;
  late String username;
  late String password1;
  late String password2;
  late String email;
  late String phone;
  late List<String> languages;
  //late List<String> location;

  late String id;
  var storage;
  Future<User> fetchUser() async {
    log("fetchUser");
    storage = LocalStorage('Users');
    await storage.ready;
    log("Abans storage");
    id = storage.getItem('userID');
    log("Despres storage");
    return UserService.getUserByID(id);
  }

  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureUser,
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return new Scaffold(
              body: new FlutterMap(
                options: new MapOptions(
                  center: new LatLng(41.441392, 2.186303), //AQUI!!
                  zoom: 13.0,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return Text("© OpenStreetMap contributors");
                    },
                  ),
                  new MarkerLayerOptions(markers: [
                    Marker(
                        width: 80.0,
                        height: 80.0,
                        point: new LatLng(41.441392, 2.186303), //AQUÍ!!
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
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}
