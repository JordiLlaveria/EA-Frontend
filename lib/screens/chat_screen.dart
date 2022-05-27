import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:frontend/models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  const ChatScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatModel> _messages = [];

  final bool _showSpinner = false;
  final bool _showVisibleWidget = false;
  final bool _showErrorIcon = false;

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  late Socket socket;
  static const apiURL = String.fromEnvironment('API_URL',
        defaultValue: 'http://localhost:3000');

  @override
  void initState() {
    try {
      socket =
          io(apiURL, <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      });

      socket.connect();

      socket.on('connect', (data) {
        debugPrint('connected');
        print(socket.connected);
      });

      socket.on('message', (data) {
        var message = ChatModel.fromJson(data);
        setStateIfMounted(() {
          _messages.add(message);
        });
      });

      socket.onDisconnect((_) => debugPrint('disconnect'));
    } catch (e) {
      print(e);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Community Chat'),
          foregroundColor: Colors.black.withOpacity(0.5),
          backgroundColor: Color.fromARGB(255, 255, 255, 255)),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFEAEFF2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    reverse: _messages.isEmpty ? false : true,
                    itemCount: 1,
                    shrinkWrap: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 3),
                        child: Column(
                          mainAxisAlignment: _messages.isEmpty
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: _messages.map((message) {
                                  print(message);
                                  return ChatBubble(
                                    username: message.username,
                                    date: message.sentAt,
                                    message: message.message,
                                    isMe: message.id == socket.id,
                                  );
                                }).toList()),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    bottom: 10, left: 20, right: 10, top: 5),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: TextField(
                          minLines: 1,
                          maxLines: 5,
                          controller: _messageController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration.collapsed(
                            hintText: "Type a message",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 43,
                      width: 42,
                      child: FloatingActionButton(
                        backgroundColor: Colors.blue,
                        onPressed: () async {
                          if (_messageController.text.trim().isNotEmpty) {
                            String message = _messageController.text.trim();

                            socket.emit(
                                "message",
                                ChatModel(
                                        id: socket.id!,
                                        message: message,
                                        username: widget.username,
                                        sentAt: DateTime.now()
                                            .toLocal()
                                            .toString()
                                            .substring(0, 16))
                                    .toJson());

                            _messageController.clear();
                          }
                        },
                        mini: true,
                        child: Transform.rotate(
                            angle: 5.79449,
                            child: const Icon(Icons.send, size: 20)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String date;
  final String username;

  ChatBubble({
    Key? key,
    required this.username,
    required this.message,
    this.isMe = true,
    required this.date,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            constraints: BoxConstraints(maxWidth: size.width * .5),
            decoration: BoxDecoration(
              color: isMe ? Color.fromARGB(255, 216, 237, 255) : const Color(0xFFFFFFFF),
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topRight: Radius.circular(11),
                      topLeft: Radius.circular(11),
                      bottomRight: Radius.circular(0),
                      bottomLeft: Radius.circular(11),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(11),
                      topLeft: Radius.circular(11),
                      bottomRight: Radius.circular(11),
                      bottomLeft: Radius.circular(0),
                    ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "@"+username/*  ?? '' */,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 64, 116, 151), fontSize: 10),
                ),
                Text(
                  message/*  ?? '' */,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 25, 60, 99), fontSize: 14),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(
                      date/*  ?? '' */,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 64, 116, 151), fontSize: 9),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}