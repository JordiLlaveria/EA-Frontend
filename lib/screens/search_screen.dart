import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/icons/search_icons.dart';

import '../widgets/bottom_search_user.dart';
import '../screens/filter_user_screen.dart';
import 'package:frontend/services/user_service.dart';
import '../models/user_model.dart';
import '../widgets/search_user_form.dart';
import '../widgets/icon_container.dart';
import 'package:localstorage/localstorage.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  UserService userService = UserService();
  List<User> users = [];
  List<String> peopleliked = [];
  List<String> peopledisliked = [];
  late User userselected;
  bool _isLoading = true;
  late String name;
  var storage;
  late String id;
  late String token;

  void initState() {
    super.initState();
    initiateVariables();
    getUser(id);
    getUsers();
  }

  Future<void> updateUser() async {
    await UserService.updateUserByID(id, token, peopleliked, peopledisliked);
  }

  Future<void> initiateVariables() async {
    storage = LocalStorage('Users');
    await storage.ready;
    id = storage.getItem('userID');
    //print("The id of the user in search screen is " + id);
    token = storage.getItem('token');
  }

  Future<void> getUser(String id) async {
    userselected = await UserService.getUserByID(id);
    print("The user selected is " + userselected.name);
  }

  Future<void> getUsers() async {
    users = await UserService.getUsers();
    setState(() {
      _isLoading = false;
    });
    print("The id is: " + id);
    for (int i = 0; i < users.length; i++) {
      if (users[i].id == id) {
        users.remove(users[i]);
      }
    }
    //print(users);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    users.isEmpty
                        ? Center(child: Text('No more users'))
                        : Expanded(
                            child:
                                Stack(children: users.map(buildUser).toList())),
                    BottomSearchButtons()
                  ],
                ))));
  }

  @override
  Widget buildUser(dynamic user) {
    final userIndex = users.indexOf(user);
    return Positioned(
        top: 20,
        bottom: 20,
        child: Center(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Draggable(
                    child: SearchUserForm(user: user),
                    feedback: Material(
                      type: MaterialType.transparency,
                      child: SearchUserForm(user: user),
                    ),
                    childWhenDragging: Container(),
                    onDragEnd: (details) => whereMoved(details, user)))));
  }

  Widget BottomSearchButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //       primary: Colors.white,
        //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(40),
        //       )),
        //   onPressed: () {},
        //   child: Icon(Icons.replay, color: Colors.yellow),
        // ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              )),
          onPressed: () {
            // final route = MaterialPageRoute(
            //     builder: (context) => FilterUser(users: users));
            // Navigator.push(context, route);
          },
          child: Icon(Icons.filter_alt_rounded, color: Colors.grey),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              )),
          onPressed: () {},
          child: Icon(Icons.close, color: Colors.red),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              )),
          onPressed: () {},
          child: Icon(Icons.favorite, color: Colors.green),
        ),
      ],
    );
  }

  // void ComeBackFromFilter(List<User> users) {}

  void whereMoved(DraggableDetails details, User user) {
    final minimumDrag = 100;
    print("The id of the user when moved is " + id);
    if (details.offset.dx > minimumDrag) {
      print('The user liked is ' + user.name);
      peopleliked.add(user.id);
    } else if (details.offset.dx < -minimumDrag) {
      print('The user unliked is ' + user.name);
      peopledisliked.add(user.id);
    }
    print('I am going to update user');
    updateUser();
    print('Voy a construir un nuevo user');
    setState((() => users.remove(user)));
  }
}
