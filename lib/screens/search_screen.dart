import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/icons/search_icons.dart';

import '../widgets/bottom_search_user.dart';
import 'package:frontend/services/user_service.dart';
import '../models/user_model.dart';
import '../widgets/search_user_widget.dart';
import '../widgets/icon_container.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> users = [];
  Future<List<dynamic>> fetchUser() async {
    users = await UserService.getUsers();
    return users;
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              users.isEmpty
                  ? Text('No more users')
                  : Stack(children: users.map(buildUser).toList()),
              Expanded(child: Container()),
              BottomSearchUserWidget()
            ],
          )));

  Widget buildAppBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(Icons.chat, color: Colors.grey),
          SizedBox(width: 16),
        ],
        leading: Icon(Icons.person, color: Colors.grey),
      );

  @override
  Widget buildUser(dynamic user) {
    final userIndex = users.indexOf(user);
    final isUserInFocus = userIndex == users.length - 1;

    return Draggable(
      child: SearchUserWidget(user: user, isUserInFocus: isUserInFocus),
      feedback: Material(
        type: MaterialType.transparency,
        child: SearchUserWidget(user: user, isUserInFocus: isUserInFocus),
      ),
      childWhenDragging: Container(),
      onDragEnd: (details) => onDragEnd(details, users[0]),
    );
  }

  void onDragEnd(DraggableDetails details, User user) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      user.nolike = true;
    } else if (details.offset.dx < -minimumDrag) {
      user.like = true;
    }
    setState((() => users[1]));
  }
}
