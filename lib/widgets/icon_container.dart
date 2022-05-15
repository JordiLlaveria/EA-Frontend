import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final String url;
  const IconContainer({ Key? key, required this.url})
          : assert(url != null),
            super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 220.0,
      child: CircleAvatar(
        radius: 200.0,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(this.url),
        //Definixo la ruta de la imatge en 'pubspex.yaml'
      ),
    );
  }
}