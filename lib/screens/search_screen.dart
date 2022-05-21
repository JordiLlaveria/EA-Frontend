import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/icons/search_icons.dart';

import '../widgets/bottom_search_user.dart';
import 'package:frontend/services/user_service.dart';
import '../models/user_model.dart';
import '../widgets/search_user_form.dart';
import '../widgets/icon_container.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  UserService userService = UserService();
  List<User> users = [];
  bool _isLoading = true;

  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    users = await userService.getUsers();
    setState(() {
      _isLoading = false;
    });
    print(users);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: Container(
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        users.isEmpty
                            ? Text('No more users')
                            : Stack(children: users.map(buildUser).toList()),
                        Expanded(child: Container()),
                        BottomSearchUserWidget()
                      ],
                    )))));
  }

  // Widget buildAppBar() => AppBar(
  //       centerTitle: true,
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //       actions: [
  //         Icon(Icons.chat, color: Colors.grey),
  //         SizedBox(width: 16),
  //       ],
  //       leading: Icon(Icons.person, color: Colors.grey),
  //     );

  @override
  Widget buildUser(dynamic user) {
    final userIndex = users.indexOf(user);
    print('Inside Draggable');
    return Container(
        width: 200,
        height: 150,
        child: Draggable(
            child: SearchUserForm(user: user),
            feedback: Material(
              type: MaterialType.transparency,
              child: SearchUserForm(user: user),
            ),
            childWhenDragging: Container(),
            onDragEnd: (details) => onDragEnd(details, user)));
  }

  void onDragEnd(DraggableDetails details, User user) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      user.nolike = true;
    } else if (details.offset.dx < -minimumDrag) {
      user.like = true;
    }
    setState((() => users.remove(user)));
  }
}
