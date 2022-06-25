//import 'dart:html';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/storage_service.dart';
import 'package:frontend/widgets/input_text.dart';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../screens/app_screen.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey keyName;
  final GlobalKey keyUsername;
  final GlobalKey keyLanguages;
  final GlobalKey keyButton;
  const RegisterForm(
      {Key? key,
      required this.keyName,
      required this.keyUsername,
      required this.keyLanguages,
      required this.keyButton})
      : super(key: key);
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  AuthService service = AuthService();
  Storage storage = Storage();
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String surname;
  late String username;
  late String password1;
  late String password2;
  late String email;
  late String phone;
  late String photo;
  late List? _myLanguages = [];
  late List<String> location = [];
  late var fileName;
  late var fileBytes;

  final _controller = TextEditingController();

  void onPressedMethod(String location) {
    _controller.text = location;
    print(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _register() async {
    photo = fileName;
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      if (password1 == password2) {
        if (await service.register(name, surname, username, password1, email,
            phone, location, _myLanguages!.cast<String>(), photo, false)) {
          final route = MaterialPageRoute(builder: (context) => AppScreen());
          Navigator.push(context, route);
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('PASSWORD IS NOT THE SAME'),
                  content: Text('Please write the same password twice'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
              key: widget.keyName,
              child: Column(
                children: [
                  InputText(
                    label: 'Your name',
                    hint: 'Name',
                    keyboard: TextInputType.name,
                    icon: Icon(Icons.account_box,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    onChanged: (data) {
                      name = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputText(
                    label: 'Your surname',
                    hint: 'Surname',
                    keyboard: TextInputType.name,
                    icon: Icon(Icons.account_box_outlined,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    onChanged: (data) {
                      surname = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputText(
                    label: 'Your email',
                    hint: 'Email',
                    keyboard: TextInputType.emailAddress,
                    icon: Icon(Icons.email,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  SizedBox(height: 20),
                  InputText(
                    label: 'Your phone',
                    hint: 'Phone',
                    keyboard: TextInputType.phone,
                    icon: Icon(Icons.phone,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    onChanged: (data) {
                      phone = data;
                    },
                  ),
                ],
              )),
          SizedBox(height: 20),
          Container(
              key: widget.keyUsername,
              child: Column(
                children: [
                  InputText(
                    label: 'Choose a username',
                    hint: 'Username',
                    keyboard: TextInputType.name,
                    icon: Icon(Icons.sentiment_satisfied,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    onChanged: (data) {
                      username = data;
                    },
                  ),
                  SizedBox(height: 20),
                  passwordInputText(
                      label: "Choose a password",
                      onChanged: (data) {
                        password1 = data;
                      }),
                  SizedBox(height: 20),
                  passwordInputText(
                      label: "Repeat your password",
                      onChanged: (data) {
                        password2 = data;
                      }),
                ],
              )),
          SizedBox(height: 20),
          Container(
            key: widget.keyLanguages,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(115, 255, 255, 255),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MultiSelectFormField(
                  chipBackGroundColor: Color.fromARGB(255, 255, 255, 255),
                  chipLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.deepOrangeAccent,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  title: Text(
                    "Language",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontFamily: 'FredokaOne'),
                  ),
                  fillColor: Colors.transparent,
                  dataSource: [
                    {
                      "display": "Catalan",
                      "value": "Catalan",
                    },
                    {
                      "display": "Spanish",
                      "value": "Spanish",
                    },
                    {
                      "display": "English",
                      "value": "English",
                    },
                    {
                      "display": "French",
                      "value": "French",
                    },
                    {
                      "display": "Italian",
                      "value": "Italian",
                    },
                    {
                      "display": "German",
                      "value": "German",
                    },
                    {
                      "display": "Portuguese",
                      "value": "Portuguese",
                    },
                    {
                      "display": "Russian",
                      "value": "Russian",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text(
                    'Please choose one or more',
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                  initialValue: _myLanguages,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myLanguages = value;
                    });
                  },
                  change: (values) {
                    _myLanguages = values;
                  },
                ),
              ),
              SizedBox(height: 20),
              locationInputText(
                label: 'Your location',
                onChanged: (data) {
                  location = data.split(',');
                },
              ),
              Container(
                child: Column(children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var locationstring = await _getCurrentLocation();
                      var parts = locationstring.split(',');
                      location.add(parts[0].trim());
                      location.add(parts[1].trim());
                      onPressedMethod(location.toString());
                    },
                    color: Colors.red,
                    child: Text("Find My Location"),
                  )
                ]),
              ),
              SizedBox(height: 20),
              photoButton(
                  title: 'Pick photo',
                  icon: Icons.camera_alt_outlined,
                  onClicked: () => pickImage()),
            ]),
          ),
          SizedBox(height: 20),
          Container(
            key: widget.keyButton,
            child: Material(
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

  Widget passwordInputText(
      {required String label, required void Function(String data) onChanged}) {
    return Container(
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          if (validateStructure(value) == false) {
            return 'Password must have capital letters, numbers and symbols';
          }
          if (value.length < 8) {
            return 'Password must have more than 8 characters';
          }
        },
        decoration: InputDecoration(
            hintText: 'Password',
            labelText: label,
            labelStyle: TextStyle(
                color: Color.fromARGB(255, 238, 241, 243),
                fontFamily: 'FredokaOne',
                fontSize: 15.0),
            suffixIcon:
                Icon(Icons.lock, color: Color.fromARGB(255, 255, 255, 255)),
            suffixIconColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20.0)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(20.0),
            ),
            errorStyle: TextStyle(color: Colors.white)),
      ),
    );
  }

  bool validateStructure(String value) {
    String pattern = r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Widget locationInputText(
      {required String label, required void Function(String data) onChanged}) {
    return Container(
      child: TextFormField(
        onChanged: onChanged,
        controller: _controller,
        decoration: InputDecoration(
            hintText: 'Longitude, Latitude',
            labelText: label,
            labelStyle: TextStyle(
                color: Color.fromARGB(255, 238, 241, 243),
                fontFamily: 'FredokaOne',
                fontSize: 15.0),
            suffixIcon: Icon(Icons.add_location_alt,
                color: Color.fromARGB(255, 255, 255, 255)),
            suffixIconColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20.0)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(20.0),
            ),
            errorStyle: TextStyle(color: Colors.white)),
      ),
    );
  }
}

Future<String> _getCurrentLocation() async {
  final cordenades = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  String cord = "${cordenades.latitude}, ${cordenades.longitude}";
  print(cord);
  return cord;
}
