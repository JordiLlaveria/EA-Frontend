import 'package:flutter/material.dart';

class BottomSearchUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.replay, color: Colors.yellow),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.close, color: Colors.red),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.green),
          ),
        ],
      );
}
