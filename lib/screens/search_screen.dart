import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/icons/search_icons.dart';

import 'package:frontend/services/user_service.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
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
  String? languageselected;

  GlobalKey keyUser = GlobalKey();
  GlobalKey keyButtons = GlobalKey();
  GlobalKey keyFilter = GlobalKey();

   var storageTutorial;

  List<TargetFocus> targets = <TargetFocus>[];

  late TutorialCoachMark tutorialCoachMark;

  void initState() {
    initTarget();
    WidgetsBinding.instance?.addPostFrameCallback(_afterlayaout);
    super.initState();
    getUser();
    getUsers();
  }

  void _afterlayaout(_) {
    Future.delayed(Duration(milliseconds: 100));
    showTutorial();
  }

  void showTutorial() async {
    storageTutorial = LocalStorage('Tutorial');
    await storageTutorial.ready;
    if(storageTutorial.getItem('search') == true){      
      storageTutorial.setItem('search', false);
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      alignSkip: Alignment.topRight,
      colorShadow: Theme.of(context).cardColor,
      opacityShadow: 0.95,
    )..show();
    }
  }

  void initTarget() {
    targets.add(TargetFocus(
        identify: "User",
        targetPosition: TargetPosition(Size(400,400), Offset(190,100)),
        shape: ShapeLightFocus.Circle,
        enableOverlayTab: true,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "WELCOME TO THE SEARCH SCREEN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 30.0,
                          fontFamily: 'FredokaOne'),
                    ),
                    Text(
                      "In this screen you can find users and see which language they speak and their location. If you like a user you can swipe them right and if you don't like them you can swipe them left.",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ]));
      targets.add(TargetFocus(
        identify: "Buttons",
        keyTarget: keyButtons,
        shape: ShapeLightFocus.RRect,
        radius: 20,
        enableOverlayTab: true,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    
                    Text(
                      "You can also use the buttons to like a user.",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ]));
      targets.add(TargetFocus(
        identify: "Filter",
        keyTarget: keyFilter,
        shape: ShapeLightFocus.RRect,
        radius: 20,
        enableOverlayTab: true,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[     
                    Text(
                      "FILTER",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 20.0,
                          fontFamily: 'FredokaOne'),
                    ),               
                    Text(
                      "To filter the users by their languages you can use this field",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ]));
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
    peopleliked = userselected.peopleliked!;
    peopledisliked = userselected.peopledisliked!;
  }

  Future<void> getUsers() async {
    usersAPI = await UserService.getUsers();
    setState(() {
      _isLoading = false;
    });
    bool found = false;
    bool matchlanguage = true;
    usersToShow = [];
    for (int i = 0; i < usersAPI.length; i++) {
      found = false;
      matchlanguage = true;
      if (usersAPI[i].id == id) {
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
            found = true;
          }
        }
      }
      if (languageselected != null &&
          languageselected != 'No language filter') {
        matchlanguage = false;
        for (int j = 0; j < usersAPI[i].languages.length; j++) {
          if (usersAPI[i].languages[j] == languageselected) {
            matchlanguage = true;
          }
        }
      }
      if (found == false && matchlanguage == true) {
        usersToShow.add(usersAPI[i]);
      }
    }
    //print(users);
  }

  @override
  Widget build(BuildContext context) {
    if (usersToShow.isEmpty == true) {
      return Center(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                                  children:
                                      usersToShow.map(buildUser).toList())),
                      BottomSearchButtonsNoUsers(),
                    ],
                  ))));
    } else {
      return Center(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                                  children:
                                      usersToShow.map(buildUser).toList())),
                      BottomSearchButtons(usersToShow[usersToShow.length - 1]),
                    ],
                  ))));
    }
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

  Widget BottomSearchButtons(User user) {
    final languages = [
      'Catalan',
      'Spanish',
      'English',
      'French',
      'Italian',
      'German',
      'Portuguese',
      'Russian',
      'No language filter'
    ];
    return Container(
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.width / 20,
        child: Row(
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
            //FilterButton(),
            Container(
              key: keyFilter,
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                value: languageselected,
                iconSize: 22,
                items: languages.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() {
                  languageselected = value;
                  usersToShow = [];
                  //getUser();
                  getUsers();
                  build(context);
                }),
              )),
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       primary: Colors.white,
            //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(40),
            //       )),
            //   onPressed: () {
            //     // style:
            //     // ButtonStyle(overlayColor: MaterialStateProperty.resolveWith<Color?>(
            //     //   (Set<MaterialState> states) {
            //     //     if (states.contains(MaterialState.pressed)) return Colors.green;
            //     //     return null;
            //     //   },
            //     // ));
            //     // final route = MaterialPageRoute(
            //     //     builder: (context) => FilterUser(users: usersToShow));
            //     // Navigator.push(context, route);
            //   },
            //   child: Icon(Icons.filter_alt_rounded, color: Colors.grey),
            // ),
            Container(
              key: keyButtons,
              child: Row(children: [
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  )),
              onPressed: () {
                MovedButton(-125, user);
              },
              child: Icon(Icons.close, color: Colors.red),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  )),
              onPressed: () {
                MovedButton(125, user);
              },
              child: Icon(Icons.favorite, color: Colors.green),
            )
              ],)
            ),
          ],
        ));
  }

  Widget BottomSearchButtonsNoUsers() {
    final languages = [
      'Catalan',
      'Spanish',
      'English',
      'French',
      'Italian',
      'German',
      'Portuguese',
      'Russian',
      'No language filter'
    ];
    return Container(        
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.width / 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                value: languageselected,
                iconSize: 22,
                items: languages.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() {
                  languageselected = value;
                  getUsers();
                }),
              )),
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       primary: Colors.white,
            //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(40),
            //       )),
            //   onPressed: () {},
            //   child: Icon(Icons.filter_alt_rounded, color: Colors.grey),
            // ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  )),
              onPressed: () {
                //MovedButton(-125, user);
              },
              child: Icon(Icons.close, color: Colors.red),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  )),
              onPressed: () {
                //MovedButton(125, user);
              },
              child: Icon(Icons.favorite, color: Colors.green),
            ),
          ],
        ));
  }

  void MovedButton(int movement, User user) {
    final minimumDrag = 100;
    if (movement > minimumDrag) {
      peopleliked.add(user.id);
    } else if (movement < -minimumDrag) {
      peopledisliked.add(user.id);
    }
    print('I am going to update user');
    updateUser();
    print('Voy a construir un nuevo user');
    setState((() => usersToShow.remove(user)));
  }

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
      peopledisliked.add(user.id);
    }
    print('I am going to update user');
    updateUser();
    print('Voy a construir un nuevo user');
    setState((() => usersToShow.remove(user)));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item, child: Text(item, style: TextStyle(fontSize: 20)));
}
