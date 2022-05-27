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
  bool _isLoading = true;
  late String name;

  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    users = await userService.getUsers();
    setState(() {
      _isLoading = false;
    });
    // name = LocalStorage('Users').getItem('userName');
    // print("The name found is " + name);
    // for (dynamic i in users) {
    //   if (users[i].name == name) {
    //     users.remove(users[i]);
    //   }
    // }
    print(users);
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

  void ComeBackFromFilter(List<User> users) {}

  void whereMoved(DraggableDetails details, User user) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      print('The user liked is ' + user.name);
      user.nolike = true;
    } else if (details.offset.dx < -minimumDrag) {
      print('The user unliked is ' + user.name);
      user.like = true;
    }
    print('Voy a construir un nuevo user');
    setState((() => users.remove(user)));
  }
}
