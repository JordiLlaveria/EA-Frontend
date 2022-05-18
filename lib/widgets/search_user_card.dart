import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package/tinder_swipe_cards/provider/card_provider.dart';

final String photo =
    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.es%2Ffotos-vectores-gratis%2Fpersonas&psig=AOvVaw31o2wAARt0Apf3f0r13AUv&ust=1652941838721000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCNDN1dm26PcCFQAAAAAdAAAAABAJ";

class SearchUser extends StatefulWidget {
  @override
  State<SearchUser> createState() => _SearchUser();
}

class _SearchUser extends State<SearchUser> {
  @override
  Widget build(BuildContext context) => SizedBox.expand(child: buildCard());

  Widget buildCard() => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(photo),
            fit: BoxFit.cover,
            alignment: Alignment(-0.3, 0),
            scale: 1.0,
          ),
        ),
      );
}
