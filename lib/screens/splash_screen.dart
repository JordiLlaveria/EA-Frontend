import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/app_screen.dart';
import 'package:frontend/screens/index_screen.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/widgets/icon_container.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  void initState(){
    new Future.delayed(const Duration(seconds: 3), () => getValidationData());
    super.initState();
  }

  void getValidationData() async{
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getString('user');   
    print(user); 

    if(user == null){
      final route = MaterialPageRoute(
        builder: (context) => IndexScreen());
      Navigator.push(context, route);
    }
    else{
      final LocalStorage storage = LocalStorage('Users');
      storage.setItem('username', user);
      var id = sharedPreferences.getString('userId');
      storage.setItem('userID', id);
      final route = MaterialPageRoute(
        builder: (context) => AppScreen()); 
      Navigator.push(context, route);
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromARGB(255, 166, 105, 44),
                Color.fromARGB(255, 181, 37, 76)
              ],
              begin: Alignment.topCenter
            )
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 200
            ),
            children: <Widget> [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                IconContainer(
                url: 'imatges/Logo.PNG'
                ),
                Text(
                  'PROJECTE EA: XERRA',
                  style: TextStyle(
                    fontFamily: 'FredokaOne',
                    fontSize: 30.0
                  ),
                ),
                Text(
                  '[GRUP 1]',
                  style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    fontSize: 18.0
                  ) ,
                ),                
              ],
            )
          ],
        ),
      ),
    ),
  );
}
}
