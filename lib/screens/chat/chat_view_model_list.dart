import 'package:frontend/models/chat_model.dart';
import 'package:frontend/services/message_service.dart';
/* import 'package:frontend/services/user_service.dart'; */
import 'package:frontend/screens/chat/chat_view_model.dart';
import 'package:mobx/mobx.dart';

import '../../models/chat_model.dart';
import 'chat_view_model.dart';

part 'chat_view_model_list.g.dart';

class ChatListState = ChatListVM with _$ChatListState;

enum MessageStatus { loading, loaded, empty }

abstract class ChatListVM with Store {
  @observable
  MessageStatus messageStatus = MessageStatus.empty;

  @observable
  ObservableList<ChatViewModel> messageList = ObservableList<ChatViewModel>();

  @observable
  ObservableList<String> writingUsers = ObservableList<String>();

  @action
  Future<void> fetchMessage(String receiverID) async {
    messageStatus = MessageStatus.loading; // Veriler Getiriliyor
    var list = await MessageService.fetchMessageList(receiverID);
    messageList =
        ObservableList.of((list.map((e) => ChatViewModel(chat: e))));

    if (messageList.isNotEmpty) {
      // Veri Var ise
      messageStatus = MessageStatus.loaded;
    } else {
      messageStatus = MessageStatus.empty;
    }
  }

  @action
  addMessage({required String message, required bool isMy}) {
    messageList.add(ChatViewModel(
        chat: Chat(
            message: message,
            isMy: isMy,
            createdAt: DateTime.now().toString())));
    messageStatus = MessageStatus.loaded;
  }

  @action
  setWritingUsers(List<String> writing) {
    writingUsers = ObservableList.of(writing);
  }
}
