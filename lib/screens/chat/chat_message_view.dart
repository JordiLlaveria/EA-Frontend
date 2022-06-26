import 'dart:convert';
import 'package:frontend/screens/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  final ChatViewModel message;
  const ChatMessage({required this.message, bool? isMy});

  @override
  Widget build(BuildContext context) {
    return buildText(context);
  }

  Widget buildText(BuildContext context) {
    return Align(
      alignment: message.isMy ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        child: Column(
          crossAxisAlignment:
              message.isMy ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: message.isMy ? Color(0xFF1289FD) : Color(0xFFE5E4EA)),
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              child: Text(message.content,
                      style: TextStyle(color: message.isMy ? Colors.white : Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12,bottom: 4),
              child: Text(DateFormat('HH:mm')
                  .format(DateTime.parse(message.createdAt)),style: TextStyle(color: Colors.blueGrey,fontSize: 14,fontWeight: FontWeight.w500),),
            )
          ],
        ),
      ),
    );
  }
}
