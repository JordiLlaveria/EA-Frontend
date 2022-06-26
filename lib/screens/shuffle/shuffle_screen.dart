import 'package:frontend/helper/base_state.dart';
import 'package:frontend/helper/get_it.dart';
import 'package:frontend/helper/preferences_helper.dart';
import 'package:frontend/helper/socket_helper.dart';
import 'package:frontend/models/group_chat_model.dart';
import 'package:frontend/screens/chat/group_chat_screen.dart';
import 'package:frontend/screens/shuffle/shuffle_view_model_list.dart';
import 'package:frontend/screens/shuffle/shuffle_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:frontend/screens/index_screen.dart';
import 'package:localstorage/localstorage.dart';

class ShuffleView extends StatefulWidget {
  @override
  _ShuffleViewState createState() => _ShuffleViewState();
}

class _ShuffleViewState extends BaseState<ShuffleView> {
  var shuffleVM = getIt<ShufListState>();

  static String username = LocalStorage('Users').getItem('username');

  Widget _buildShuffleList(ShuffleListVM vm) {
    return Observer(builder: (context) {
      switch (vm.status) {
        case ListStatus.loading:
          return Center(child: CircularProgressIndicator());
          break;
        case ListStatus.loaded:
          return ShuffleList();
          break;
        case ListStatus.empty:
          return Center(
            child: Text("Data not available"),
          );
          break;
        default:
          return Container();
      }
    });
  }

  @override
  void initState() {
    SocketHelper.shared.connectSocket();
    shuffleVM.fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chats'),
        actions: [
          IconButton(
              icon: Icon(Icons.groups),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => GroupChatScreen(username: username)),
                    (route) => false);
              })
        ],
      ),
      body: _buildShuffleList(shuffleVM),
    );
  }
}
