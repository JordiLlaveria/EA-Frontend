import 'package:frontend/models/chat_model.dart';

class ChatViewModel{

  final Chat _chat;

  ChatViewModel({required Chat chat}) : _chat = chat;

  String get content => _chat.message;
  bool get isMy => _chat.isMy;
  String get createdAt => _chat.createdAt;

}