import 'package:frontend/helper/get_it.dart';
import 'package:frontend/screens/chat/chat_view_model_list.dart';
import 'package:frontend/screens/chat/chat_message_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessageListView extends StatelessWidget {
  final vm = getIt<ChatListState>();
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  MessageListView({required this.itemScrollController, required this.itemPositionsListener});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return NotificationListener(
        onNotification: (notification) {
          if (notification is UserScrollNotification) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
          return false;
        },
        child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            itemCount: vm.messageList.length,
            itemBuilder: (context, index) {
              return ChatMessage(
                  isMy: vm.messageList[index].isMy,
                  message: vm.messageList[index]);
            }),
      );
    });
  }
}
