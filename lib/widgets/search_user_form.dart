import 'package:flutter/material.dart';
import 'package:frontend/services/storage_service.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../models/location_model.dart';
import '../models/user_model.dart';

class SearchUserForm extends StatefulWidget {
  final User user;
  late String loctions;
  SearchUserForm({Key? key, required this.user}) : super(key: key);

  @override
  State<SearchUserForm> createState() => _SearchUserState(user: user);
}

class _SearchUserState extends State<SearchUserForm> {
  Storage storage = Storage();
  User user;

  String locations = "";
  String languages = "";

  

  _SearchUserState({required this.user});
  @override
  Widget build(BuildContext context) {
    //print("The user shown is " + user.username);
    return Center(
        child: Container(
      
      height: MediaQuery.of(context).size.height / 1.2,
      width: MediaQuery.of(context).size.width / 1.2,
      child: Stack(
        children: [
          ShowImage(user),
          Container(            
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black12, spreadRadius: 0.5),
                ],
                gradient: LinearGradient(
                  colors: [Colors.black12, Colors.black87],
                  begin: Alignment.center,
                  stops: [0.4, 1],
                  end: Alignment.bottomCenter,
                )),
          ),
          Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: EmptySpace()),
                Expanded(child: EmptySpace()),
                Expanded(child: EmptySpace()),
                Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: UserInformation(user: user)),
                ),
              ],
            ),
          ]),
        ],
      ),
    ));
  }

  Widget ShowImage(User user) {
    if (user.fromGoogle == true) {
      return Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(user.photo, fit: BoxFit.cover)));
    } else {
      return Scaffold(
          body: FutureBuilder(
              future: storage.downloadURL(user.photo),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(snapshot.data!, fit: BoxFit.cover));
                }
                return Container();
              }));
    }
  }

  Widget EmptySpace() => Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Text(
            '',
          )),
          Expanded(
            child: Text(
              '',
            ),
          ),
          Expanded(
              child: Text(
            '',
          )),
        ],
      ));
  Widget UserInformation({required User user}) => Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              '${user.name} ${user.surname}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 1),
          Expanded(
            child: Text(
              locations = GetLocations(user.location),
              semanticsLabel: '${locations}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 1),
          Expanded(
              child: Text(
            languages = GetLanguages(user.languages),
            semanticsLabel: '${languages}',
            style: TextStyle(color: Colors.white),
          )),
        ],
      ));
}

String GetLocations(Location locations) {
  String location = "";
  location = locations.coordinates[0].toString();
  for (var i = 1; i < locations.coordinates.length; i++) {
    location = location + ", " + locations.coordinates[i].toString();
  }
  return location;
}

String GetLanguages(List<dynamic> languagesList) {
  String languages = "";
  languages = languagesList[0];
  for (var i = 1; i < languagesList.length; i++) {
    languages = languages + ", " + languagesList[i];
  }
  return languages;
}
