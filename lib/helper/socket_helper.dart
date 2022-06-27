import 'package:frontend/helper/get_it.dart';
import 'package:frontend/helper/preferences_helper.dart';
import 'package:frontend/helper/stream_controller_helper.dart';
import 'package:frontend/screens/chat/chat_view_model_list.dart';
import 'package:frontend/screens/shuffle/shuffle_view_model_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketHelper {

  static final shared = SocketHelper();
  ChatListState vm = ChatListState();
  late IO.Socket socket;
  static const apiURL =
    String.fromEnvironment('API_URL', defaultValue: 'http://localhost:3000');
  var id;

  void connectSocket() async{
    id = await SharedPreferencesHelper.shared.getMyID();
    socket = IO.io(apiURL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.on('connect', (data) {
      socket.emit('chatID',{'id' : id});
      socket.on('receive_message', (data) {
        var content = data['content'].toString();

        getIt<ChatListState>().addMessage(message: content,isMy: false);
        StreamControllerHelper.shared.setLastIndex(getIt<ChatListState>().messageList.length);

      } );

      socket.on('onlineUsers', (data){
        var list = List<String>.from(data['users']);
        getIt<ShufListState>().setOnlineUsers(list);
        print(getIt<ShufListState>().onlineUsers);
      });

      socket.on('writingListener', (data){
        print(data);
        var list = List<String>.from(data['users']);
        getIt<ChatListState>().setWritingUsers(list);
        //print(getIt<ChatListState>().writingUsers);
      });

    });
  }

  void sendMessage({required String receiver,required String message}){
    getIt<ChatListState>().addMessage(message: message,isMy: true);
    StreamControllerHelper.shared.setLastIndex(getIt<ChatListState>().messageList.length);

    if (id != null)
      print("senderID: " + id);
    print("receiverID: " + receiver);


    socket.emit('send_message',{
      "senderChatID" : id,
      "receiverChatID" : receiver,
      "content" : message
    }); 
  }

  void addUsersWriting({required String receiver}){
    socket.emit('addWriting',{"id" : id,"to":receiver});
  }

  void removeUsersWriting({required String receiver}){
    socket.emit('removeWriting',{"id" : id,"to":receiver});
  }

}
