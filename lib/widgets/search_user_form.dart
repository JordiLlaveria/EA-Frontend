import 'package:flutter/material.dart';
import 'package:frontend/services/storage_service.dart';
import '../models/user_model.dart';

class SearchUserForm extends StatefulWidget {
  final User user;
  SearchUserForm({Key? key, required this.user}) : super(key: key);

  @override
  State<SearchUserForm> createState() => _SearchUserState(user: user);
}

class _SearchUserState extends State<SearchUserForm> {
  Storage storage = Storage();
  User user;

  _SearchUserState({required this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Stack(
            children: [
              FutureBuilder(
                  future: storage.downloadURL(user.photo),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child:
                              Image.network(snapshot.data!, fit: BoxFit.cover));
                    }
                    return Container();
                  }),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, spreadRadius: 0.5),
                  ],
                  // gradient: LinearGradient(
                  //   colors: [Colors.black12, Colors.black87],
                  //   begin: Alignment.center,
                  //   stops: [0.4, 1],
                  //   end: Alignment.bottomCenter,
                ),
              ),
              Stack(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: UserInformation(user: user),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, right: 8),
                      child: Icon(Icons.info, color: Colors.white),
                    )
                  ],
                ),
              ]),
            ],
          ),
        ));
  }

  Widget UserInformation({required User user}) => Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              '${user.name} ${user.surname}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Text(
              '${user.location[0]}',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 6),
          Expanded(
              child: Text(
            '${user.languages}',
            style: TextStyle(color: Colors.black),
          )),
        ],
      ));
}
