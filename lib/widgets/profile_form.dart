import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/inputmod_text.dart';
import 'package:frontend/models/user_model.dart';
import 'dart:developer';
import '../screens/app_screen.dart';
import 'package:localstorage/localstorage.dart';

class ProfileForm extends StatefulWidget{
  const ProfileForm({ Key? key }) : super(key: key);
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm>{

  UserService service = UserService();
  GlobalKey<FormState> _formkey = GlobalKey();

  late String name;
  late String surname;
  late String username;
  late String password1;
  late String password2;
  late String email;
  late String phone;
  late List<String> languages;
  late List<String> location;

  late String id;
  var storage;
  Future<User> fetchUser() async {
    storage = LocalStorage('Users');
    await storage.ready;

    id = LocalStorage('Users').getItem('userID');
    return UserService.getUserByID(id);
  }

  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

/*   void _profile() async{
    //if(_formKey.currentState!.validate()){
      if(password1 == password2){
        if(await service.profile(name, surname, username, password1, email, phone, languages, location)){
            final route = MaterialPageRoute(
              builder: (context) => AppScreen());
            Navigator.push(context, route); 
        };
      }
      else{
      }
    //}
  } */

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureUser,
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return Form(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.name,
                    /* hint:'Name', */
                    /* keyboard: TextInputType.name, */
                    icon: Icon(Icons.account_box),
                    onChanged: (data){
                      name = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.surname,
          /*           hint:'Surname', */
          /*           keyboard: TextInputType.name, */
                    icon: Icon(Icons.account_box_outlined),
                    onChanged: (data){
                      surname = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.username,
          /*           hint:'Username',
                    keyboard: TextInputType.name, */
                    icon: Icon(Icons.sentiment_satisfied),
                    onChanged: (data){
                      username = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.password,
          /*           hint:'Password',
                    obsecure: true, */
                    icon: Icon(Icons.lock),
                    onChanged: (data){
                      password1 = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.email,
          /*           hint:'Email',
                    keyboard: TextInputType.emailAddress, */
                    icon: Icon(Icons.email),
                    onChanged: (data){
                      email = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.phone,
          /*           hint:'Phone',
                    keyboard: TextInputType.phone, */
                    icon: Icon(Icons.phone),
                    onChanged: (data){
                      phone = data;
                    },
                  ),        
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.languages.toString(),
          /*           hint:'Languages',
                    keyboard: TextInputType.text, */
                    icon: Icon(Icons.chat_bubble_outline),
                    onChanged: (data){
                      languages = data.split(',');
                    },
                  ),
                  SizedBox(height: 20),
                  InputModText(
                    label: snapshot.data!.location.toString(),
          /*           hint:'[Longitude],[Latitude]',
                    keyboard: TextInputType.text, */
                    icon: Icon(Icons.add_location_alt),
                    onChanged: (data){
                      location = data.split(',');
                    },
                  ),
                  SizedBox(height: 20),
                  /* Material(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.redAccent,
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: (){
                        _profile();
                      },
                      child: Text(
                        "Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ), 
                  ),
                  SizedBox(height: 20), */
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  } 

}