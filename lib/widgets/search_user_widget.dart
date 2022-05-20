import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
//import 'package:tinder_ui_clone_example/provider/feedback_position.dart';

class SearchUserWidget extends StatelessWidget {
  final User user;
  final bool isUserInFocus;

  const SearchUserWidget({
    required this.user,
    required this.isUserInFocus,
  });

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<FeedbackPositionProvider>(context);
    //final swipingDirection = provider.swipingDirection;
    //final size = MediaQuery.of(context).size;

    return Container(
      width: 350,
      height: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
            user.photo,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 0.5),
            ],
            gradient: LinearGradient(
              colors: [Colors.black12, Colors.black87],
              begin: Alignment.center,
              stops: [0.4, 1],
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 10,
                left: 10,
                bottom: 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserInformation(user: user),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, right: 8),
                      child: Icon(Icons.info, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget UserInformation({required User user}) => Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${user.name} ${user.surname}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${user.location[0]}',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 6),
          Text(
            '${user.languages}',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ));
}
