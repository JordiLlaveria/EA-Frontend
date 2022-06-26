import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:frontend/helper/base_state.dart';
import 'package:frontend/helper/get_it.dart';
import 'package:frontend/helper/socket_helper.dart';
import 'package:frontend/helper/stream_controller_helper.dart';
import 'package:frontend/screens/chat/chat_view_model_list.dart';
import 'package:frontend/screens/chat/videocall_screen.dart';
import 'package:frontend/screens/shuffle/shuffle_view_model_list.dart';
import 'package:frontend/screens/chat/chat_message_list_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localstorage/localstorage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatScreen extends StatefulWidget {
  final String receiverID;
  final String clientName;

  final String username = LocalStorage('Users').getItem('username');

  // ignore: use_key_in_widget_constructors
  ChatScreen({required this.receiverID, required this.clientName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _controller = ScrollController();
  late StreamSubscription<int> subscription;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  var vm = getIt<ChatListState>();
  final state = getIt<ShufListState>();

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  @override
  void dispose() async {
    subscription.cancel();
    _controller.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (vm.messageStatus !=
        MessageStatus.empty) if (MediaQuery.of(context).viewInsets.bottom > 0) {
      itemScrollController.scrollTo(
          index: vm.messageList.length - 1,
          duration: Duration(milliseconds: 200));
    }
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            child: Stack(
              children: [
                // Pop Button - Back
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFE6E5E6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          width: 30,
                          height: 30,
                          child: Center(child: Icon(Icons.chevron_left)),
                        ),
                      )),
                ),
                // Center User info
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          widget.clientName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Observer(
                            builder: (context) => Text(
                            state.onlineUsers.contains(widget.receiverID) ? "Online" : "Offline",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Divider
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      color: Colors.black,
                      height: 0.20,
                    )),
                // User Avatar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://cdn1.iconfinder.com/data/icons/app-user-interface-glyph/64/user_man_user_interface_app_person-512.png")),
                          color: Colors.black,
                          shape: BoxShape.circle),
                    ),
                  ),
                )
              ],
            ),
          ),
          preferredSize: Size(double.infinity, 60),
        ),
        body: Column(
          children: [
            Flexible(child: buildChatScreen()),
            Container(
              width: double.infinity,
              color: Colors.black,
              height: 0.20,
            ),
            Container(
              color: Colors.white,
                padding: const EdgeInsets.only(
                    bottom: 10, left: 20, right: 10, top: 5),
              child: Row(children: <Widget>[
                  Flexible(
                    child: Container(
                      child: TextField(
                        minLines: 1,
                        maxLines: 5,
                        controller: _messageController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration.collapsed(
                          border: UnderlineInputBorder(),
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (text) => {
                          if(text.length > 1 && text.length <3){
                            SocketHelper.shared.addUsersWriting(receiver: widget.receiverID)
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 43,
                      width: 42,
                      child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        if (_messageController.text.trim().isNotEmpty) {
                          SocketHelper.shared.sendMessage(
                              receiver: widget.receiverID,
                              message: _messageController.text);
                            SocketHelper.shared.removeUsersWriting(receiver: widget.receiverID);
                          _messageController.clear();
                        }
                      },
                      mini: true,
                      child: Transform.rotate(
                          angle: 5.79449,
                          child: const Icon(Icons.send, size: 20)),
                  )),
                  SizedBox(
                  height: 43,
                  width: 42,
                  child: FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Color.fromARGB(255, 158, 217, 107),
                      onPressed: () {
                        final route = MaterialPageRoute(
                            //VideoCallScreen
                            builder: (context) => VideoCallScreen(
                                username:
                                    widget.username)); //Canviar a Signup
                        Navigator.push(context, route);
                      },
                      mini: true,
                      child: const Icon(Icons.video_camera_front_outlined,
                          size: 20)),
                ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChatScreen() {
    return Observer(builder: (_) {
      if (vm.messageStatus == MessageStatus.empty) // EMPTY
        return Stack(
          children: [
            Center(
              child: Text('Empty chat'),
            )
          ],
        );
      else if (vm.messageStatus == MessageStatus.loading) // LOADING
        return Center(child: CircularProgressIndicator());
      else
        return MessageListView(
            // LOADED WİTH DATA
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener);
    });
  }

  getMessages() async {
    subscription = StreamControllerHelper.shared.stream.listen((index) {
      if (index > 1) {
        itemScrollController.scrollTo(
            index: index - 1, duration: Duration(milliseconds: 500));
      }
    });
    await vm.fetchMessage(widget.receiverID);
    if (vm.messageStatus != MessageStatus.empty) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        itemScrollController.jumpTo(index: vm.messageList.length - 1);
      });
    }
  }
}
