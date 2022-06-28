import 'package:frontend/helper/base_state.dart';
import 'package:frontend/helper/get_it.dart';
import 'package:frontend/helper/preferences_helper.dart';
import 'package:frontend/helper/socket_helper.dart';
import 'package:frontend/models/group_chat_model.dart';
import 'package:frontend/screens/chat/chatbot_screen.dart';
import 'package:frontend/screens/chat/group_chat_screen.dart';
import 'package:frontend/screens/shuffle/shuffle_view_model_list.dart';
import 'package:frontend/screens/shuffle/shuffle_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:frontend/screens/index_screen.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ShuffleView extends StatefulWidget {
  @override
  _ShuffleViewState createState() => _ShuffleViewState();
}

class _ShuffleViewState extends BaseState<ShuffleView> {
  var shuffleVM = getIt<ShufListState>();

  static String username = LocalStorage('Users').getItem('username');

  GlobalKey keyTitle = GlobalKey();
  var storageTutorial;

  List<TargetFocus> targets = <TargetFocus>[];

  late TutorialCoachMark tutorialCoachMark;

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
            child: Text("You have not liked anyone"),
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
    initTarget();
    WidgetsBinding.instance?.addPostFrameCallback(_afterlayaout);
    super.initState();
  }

  void _afterlayaout(_) {
    Future.delayed(Duration(milliseconds: 100));
    showTutorial();
  }

  void showTutorial() async{
    storageTutorial = LocalStorage('Tutorial');
    await storageTutorial.ready;
    if(storageTutorial.getItem('shuffle') == true){
      storageTutorial.setItem('shuffle',false);
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
        identify: "Title",
        keyTarget: keyTitle,
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
                      "WELCOME TO THE CHAT SCREEN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 30.0,
                          fontFamily: 'FredokaOne'),
                    ),
                    Text(
                      "In this screen you can see all the people you liked and start chatting by clicking on them",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ]));}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(   
        key: keyTitle,     
        title: Text('Chats'),
        actions: [          
          IconButton(
              icon: Icon(Icons.groups),
              onPressed: () {
                final route = MaterialPageRoute(
                          builder: (context) =>
                              GroupChatScreen(username: username));
                      Navigator.push(context, route);
              }),
          IconButton(
              icon: Icon(Icons.smart_toy_rounded),
              onPressed: () {
                final route = MaterialPageRoute(
                          builder: (context) =>
                              ChatbotScreen());
                      Navigator.push(context, route);
              })
        ],
      ),
      body: _buildShuffleList(shuffleVM),
    );
  }
}
