import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/storage_service.dart';
import 'package:frontend/widgets/input_text.dart';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';

import '../screens/app_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  AuthService service = AuthService();
  Storage storage = Storage();
  GlobalKey<FormState> _formkey = GlobalKey();

  late String name;
  late String surname;
  late String username;
  late String password1;
  late String password2;
  late String email;
  late String phone;
  late String photo;
  late List<String> languages;
  late List<String> location;
  late var fileName;
  late var fileBytes;

  void _register() async {
    print('Trying to register');
    photo = fileName;
    //if(_formKey.currentState!.validate()){
    if (password1 == password2) {
      if (await service.register(name, surname, username, password1, email,
          phone, languages, location, photo)) {
        final route = MaterialPageRoute(builder: (context) => App());
        Navigator.push(context, route);
      }
      ;
    } else {}
    //}
  }

  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          InputText(
            label: 'Your name',
            hint: 'Name',
            keyboard: TextInputType.name,
            icon: Icon(Icons.account_box),
            onChanged: (data) {
              name = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Your surname',
            hint: 'Surname',
            keyboard: TextInputType.name,
            icon: Icon(Icons.account_box_outlined),
            onChanged: (data) {
              surname = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Choose a username',
            hint: 'Username',
            keyboard: TextInputType.name,
            icon: Icon(Icons.sentiment_satisfied),
            onChanged: (data) {
              username = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Choose a password',
            hint: 'Password',
            obsecure: true,
            icon: Icon(Icons.lock),
            onChanged: (data) {
              password1 = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Repeat your password',
            hint: 'Password',
            obsecure: true,
            icon: Icon(Icons.lock),
            onChanged: (data) {
              password2 = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Your email',
            hint: 'Email',
            keyboard: TextInputType.emailAddress,
            icon: Icon(Icons.email),
            onChanged: (data) {
              email = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Your phone',
            hint: 'Phone',
            keyboard: TextInputType.phone,
            icon: Icon(Icons.phone),
            onChanged: (data) {
              phone = data;
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Write your languages',
            hint: 'Languages',
            keyboard: TextInputType.text,
            icon: Icon(Icons.chat_bubble_outline),
            onChanged: (data) {
              languages = data.split(',');
            },
          ),
          SizedBox(height: 20),
          InputText(
            label: 'Write your location',
            hint: '[Longitude],[Latitude]',
            keyboard: TextInputType.text,
            icon: Icon(Icons.add_location_alt),
            onChanged: (data) {
              location = data.split(',');
            },
          ),
          SizedBox(height: 20),
          photoButton(
              title: 'Pick photo',
              icon: Icons.camera_alt_outlined,
              onClicked: () => pickImage()),
          SizedBox(height: 20),
          Material(
            borderRadius: BorderRadius.circular(30),
            color: Colors.redAccent,
            child: MaterialButton(
              padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                _register();
              },
              child: Text(
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget photoButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(56),
          primary: Colors.transparent,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
        onPressed: onClicked,
      );

  Future pickImage() async {
    fileName = "";
    fileBytes = "";
    print('Trying to upload image');

    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      fileBytes = result.files.first.bytes;
      fileName = result.files.first.name;
      print('The file name is ' + fileName);

      // upload file
      await FirebaseStorage.instance.ref('ea/$fileName').putData(fileBytes!);
    }

    storage.uploadFile(fileBytes, fileName).then((value) => print('Done'));
  }
}
