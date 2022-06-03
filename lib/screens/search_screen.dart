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
  List<User> usersAPI = [];
  List<User> usersToShow = [];
  List<dynamic> peopleliked = [];
  List<dynamic> peopledisliked = [];
  late User userselected;
  bool _isLoading = true;
  late String name;
  var storage;
  late String id = "";
  late String token;

  void initState() {
    super.initState();
    //initiateVariables();
    getUser();
    getUsers();
  }

  Future<void> updateUser() async {
    await UserService.updateUserByID(id, token, peopleliked, peopledisliked);
  }

  // Future<void> initiateVariables() async {
  //   storage = LocalStorage('Users');
  //   await storage.ready;
  //   id = storage.getItem('userID');
  //   //print("The id of the user in search screen is " + id);
  //   token = storage.getItem('token');
  // }

  Future<void> getUser() async {
    storage = LocalStorage('Users');
    await storage.ready;
    id = storage.getItem('userID');
    token = storage.getItem('token');
    userselected = await UserService.getUserByID(id);
    print("The userselected is " + userselected.name);
    peopleliked = userselected.peopleliked!;
    peopledisliked = userselected.peopledisliked!;
    // for (int i = 0; i < userselected.peopleliked!.length; i++) {
    //   peopleliked[i] = userselected.peopleliked![i];
    // }
    // for (int i = 0; i < userselected.peopledisliked!.length; i++) {
    //   peopledisliked[i] = userselected.peopledisliked![i];
    // }
  }

  Future<void> getUsers() async {
    usersAPI = await UserService.getUsers();
    setState(() {
      _isLoading = false;
    });
    //print("The id is: " + id);
    bool found = false;
    for (int i = 0; i < usersAPI.length; i++) {
      found = false;
      if (usersAPI[i].id == id) {
        //users.remove(users[i]);
        found = true;
      }
      if (found == false) {
        for (int j = 0; j < peopleliked.length; j++) {
          if (usersAPI[i].id == peopleliked[j] && found == false) {
            found = true;
          }
        }
      }
      if (found == false) {
        for (int j = 0; j < peopledisliked.length; j++) {
          if (usersAPI[i].id == peopledisliked[j] && found == false) {
            //users.remove(users[i]);
            found = true;
          }
        }
      }
      if (found == false) {
        usersToShow.add(usersAPI[i]);
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
                    usersToShow.isEmpty
                        ? Center(child: Text('No more users'))
                        : Expanded(
                            child: Stack(
                                children: usersToShow.map(buildUser).toList())),
                    BottomSearchButtons()
                  ],
                ))));
  }

  @override
  Widget buildUser(dynamic user) {
    final userIndex = usersToShow.indexOf(user);
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
    //print("The id of the user when moved is " + id);
    if (details.offset.dx > minimumDrag) {
      peopleliked.add(user.id);
      // int position = -1;
      // for (int i = 0; i < userselected.peopleliked!.length; i++) {
      //   if (userselected.peopleliked![i] == user.id) {
      //     position = i;
      //   }
      // }
    } else if (details.offset.dx < -minimumDrag) {
      print('The user unliked is ' + user.name);
      peopledisliked.add(user.id);
    }
    print('I am going to update user');
    updateUser();
    print('Voy a construir un nuevo user');
    setState((() => usersToShow.remove(user)));
  }

  String findPositionIfExists(User user) {
    return "";
  }
}
