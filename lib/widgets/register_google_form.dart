import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/input_text.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../screens/app_screen.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class RegisterGoogleForm extends StatefulWidget {
  final String? name;
  final String? surname;
  final String? username;
  final String? photo;
  final String? email;
  RegisterGoogleForm(
      {Key? key,
      required this.name,
      required this.surname,
      required this.username,
      required this.photo,
      required this.email})
      : super(key: key);

  @override
  State<RegisterGoogleForm> createState() => _RegisterGoogleFormState(
      name: name,
      surname: surname,
      username: username,
      photo: photo,
      email: email);
}

class _RegisterGoogleFormState extends State<RegisterGoogleForm> {
  String? name;
  String? surname;
  String? username;
  String? photo;
  String? email;
  late String password = "Google";
  late String phone;
  late List? _myLanguages = [];
  late List<String> location;
  late String photoName = name! + "" + surname! + ".jpg";
  _RegisterGoogleFormState(
      {required this.name,
      required this.surname,
      required this.username,
      required this.photo,
      required this.email});
  AuthService service = AuthService();
  Storage storage = Storage();

  void _register() async {
    if (await service.register(name, surname, username, password, email, phone,
        location, _myLanguages!.cast<String>(), photo, true)) {
      final route = MaterialPageRoute(builder: (context) => AppScreen());
      Navigator.push(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      //key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Center(
              child: TextField(
            enableInteractiveSelection: false,
            readOnly: true,
            cursorColor: Colors.white,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration.collapsed(
                hintText: 'Your name is ' + name!,
                hintStyle: TextStyle(color: Colors.white)),
          )),
          SizedBox(height: 25),
          Center(
              child: TextField(
            enableInteractiveSelection: false,
            readOnly: true,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration.collapsed(
                hintText: 'Your surname is ' + surname!,
                hintStyle: TextStyle(color: Colors.white)),
          )),
          SizedBox(height: 25),
          Center(
              child: TextField(
            enableInteractiveSelection: false,
            readOnly: true,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration.collapsed(
                hintText: 'Your username is ' + username!,
                hintStyle: TextStyle(color: Colors.white)),
          )),
          SizedBox(height: 25),
          Center(
              child: TextField(
            enableInteractiveSelection: false,
            readOnly: true,
            cursorColor: Colors.white,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration.collapsed(
                hintText: 'Your email is ' + email!,
                hintStyle: TextStyle(color: Colors.white)),
          )),
          SizedBox(height: 25),
          Container(
              //key: widget.keyName,
              child: Column(
            children: [
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
            //key: widget.keyLanguages,
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
              InputText(
                label: 'Write your location',
                hint: '[Longitude],[Latitude]',
                keyboard: TextInputType.text,
                icon: Icon(
                  Icons.add_location_alt,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onChanged: (data) {
                  location = data.split(',');
                },
              ),
            ]),
          ),
          SizedBox(height: 20),
          Container(
            //key: widget.keyButton,
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
}
