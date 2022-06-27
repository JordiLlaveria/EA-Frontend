import 'dart:html';

import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:frontend/screens/app_screen.dart';

class ChatbotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Chatbot(),
    );
  }
}

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();

  /* late DialogAuthCredentials credentials;
  late final DialogFlowtter _dialogFlowtter;

  @override
  void initState() {
    super.initState();
    loadFile;
    DialogFlowtter.fromFile(path: 'dialog_flow_auth.json')
      .then((instance) => _dialogFlowtter = instance);
  }

  void loadFile() async {
    DialogAuthCredentials credentials = await DialogAuthCredentials.fromFile('assets/dialog_flow_auth.json');
    _dialogFlowtter = DialogFlowtter(credentials: credentials);
  } */

  //final DialogFlowtter _dialogFlowtter = DialogFlowtter(credentials: credentials); */
  List<Map<String, dynamic>> messages = [];

  void sendMessage(String text) async {
    DialogAuthCredentials credentials = await DialogAuthCredentials.fromFile('assets/dialog_flow_auth.json');
    final DialogFlowtter _dialogFlowtter = DialogFlowtter(credentials: credentials);

    if (text.isEmpty) return;
    setState(() {
      Message userMessage = Message(text: DialogText(text: [text]));
      addMessage(userMessage, true);
    });

    QueryInput query = QueryInput(text: TextInput(text: text));

    DetectIntentResponse res = await _dialogFlowtter.detectIntent(
      queryInput: query,
    );

    if (res.message == null) return;

    setState(() {
      addMessage(res.message!);
    });
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black.withOpacity(0.5)),
            onPressed: () {
                final route = MaterialPageRoute(
                          builder: (context) =>
                              AppScreen());
                      Navigator.push(context, route);
              }),
          centerTitle: true,
          title: const Text('Chatbot'),
          foregroundColor: Colors.black.withOpacity(0.5),
          backgroundColor: Color.fromARGB(255, 255, 255, 255)),
      body: Column(
        children: [
          Expanded(
            child: _MessagesList(messages: messages),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.grey),
                    controller: _controller,
                    cursorColor: Colors.grey,
                    decoration: new InputDecoration.collapsed(hintText: 'Type for help'),
                  ),
                ),
/*                 IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_controller.text);
                    _controller.clear();
                  },
                ), */
                FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      mini: true,
                      child: Transform.rotate(
                          angle: 5.79449,
                          child: const Icon(Icons.send, size: 20)),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessagesList extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const _MessagesList({
    Key? key,
    this.messages = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: messages.length,

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),

      separatorBuilder: (_, i) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        var obj = messages[messages.length - 1 - i];
        return _MessageContainer(
          message: obj['message'],
          isUserMessage: obj['isUserMessage'],
        );
      },

      reverse: true,
    );
  }
}

class _MessageContainer extends StatelessWidget {
  final Message message;
  final bool isUserMessage;

  const _MessageContainer({
    Key? key,
    required this.message,
    this.isUserMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 250),
          child: Container(
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.blue : Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              message.text?.text![0] ?? '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CardContainer extends StatelessWidget {
  final DialogCard card;

  const _CardContainer({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.orange,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 150),
              child: Image.network(
                card.imageUri!,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    card.title!,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (card.subtitle != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        card.subtitle!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  if (card.buttons!.length > 0)
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: 40,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        // padding: const EdgeInsets.symmetric(vertical: 5),
                        itemBuilder: (context, i) {
                          CardButton button = card.buttons![i];
                          return FlatButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text(button.text!),
                            onPressed: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(button.postback!),
                              ));
                            },
                          );
                        },
                        separatorBuilder: (_, i) => Container(width: 10),
                        itemCount: card.buttons!.length,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}