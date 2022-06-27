import 'package:frontend/helper/get_it.dart';
import 'package:frontend/services/message_service.dart';
import 'package:frontend/screens/chat/chat_view_model_list.dart';
import 'package:frontend/screens/shuffle/shuffle_view_model.dart';
import 'package:frontend/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/shuffle/shuffle_view_model_list.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class ShuffleCard extends StatelessWidget {
  final ShuffleViewModel _user;
  final vm = getIt<ShufListState>();
  ShuffleCard({Key? key, required ShuffleViewModel user}) : _user = user, super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        getIt<ChatListState>().messageList.clear();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatScreen(
                  receiverID: _user.id!,
                  clientName: _user.name,
                )));
        await MessageService.fetchMessageList(_user.id!);
      },
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
              color: Colors.white,
              width: double.infinity,
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://cdn1.iconfinder.com/data/icons/app-user-interface-glyph/64/user_man_user_interface_app_person-512.png")),
                                shape: BoxShape.circle,
                                color: Colors.blueGrey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            _user.name,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Observer(
                              builder: (_) => Container(width: 15,height: 15,
                              decoration: 
                              BoxDecoration(color: vm.onlineUsers.contains(_user.id) ? Colors.green : Colors.red,
                              shape: BoxShape.circle),
                              ),
                          ),
                        ]),
                  ),
                  Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: 0.15,
                  )
                ],
              )),
        ),
    );
  }
}
