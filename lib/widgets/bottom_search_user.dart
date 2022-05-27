import 'package:flutter/material.dart';

class BottomSearchUserWidget extends StatelessWidget {
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //       primary: Colors.white,
          //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(40),
          //       )),
          //   onPressed: () {},
          //   child: Icon(Icons.replay, color: Colors.yellow),
          // ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                )),
            onPressed: () {},
            child: Icon(Icons.filter_alt_rounded, color: Colors.grey),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                )),
            onPressed: () {},
            child: Icon(Icons.close, color: Colors.red),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                )),
            onPressed: () {},
            child: Icon(Icons.favorite, color: Colors.green),
          )
        ],
      );
}
