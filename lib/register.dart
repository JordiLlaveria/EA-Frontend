import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

void main() => runApp(RegisterScreen());

class RegisterScreen extends StatelessWidget{
  Widget build(BuildContext context) {
    final appTitle = 'Register';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget{
  RegisterFormState createState(){
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm>{

  final _formKey = GlobalKey<FormState>();

  String? nameValue;
  String? surnameValue;
  String? usernameValue;
  String? password1Value;
  String? password2Value;
  String? emailValue;
  String? phoneValue;
  String? locationValue;
  String? languagesValue;


  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "Name", icon: Icon(Icons.account_box)),
            onSaved: (value){
              nameValue = value;
            },
            validator: (value){
              if(value!.isEmpty){
                return "This field is obligatory";
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Surname", icon: Icon(Icons.account_box_outlined)),
            onSaved: (value){
              surnameValue = value;
            },
            validator: (value){
              if(value!.isEmpty){
                return "This field is obligatory";
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Username",icon: Icon(Icons.sentiment_satisfied)),
            onSaved: (value){
              usernameValue = value;
            },
            validator: (value){
              if(value!.isEmpty){
                return "This field is obligatory";
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Password",icon: Icon(Icons.lock)),
            obscureText: true,
            onSaved: (value){
              password1Value = value;
            },
            validator: (value){
              if(value!=null && value.isEmpty){
                return "This field is obligatory";
              }if(value != password2Value){
                return "Password is not the same";
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Repeat Password",icon: Icon(Icons.lock)),
            obscureText: true,
            onSaved: (value){
              password2Value = value;
            },
            validator: (value){
              if(value!=null && value.isEmpty){
                return "This field is obligatory";
              }
              if(value != password1Value){
                return "Password is not the same";
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Email", icon: Icon(Icons.email)),
            onSaved: (value){
              emailValue = value;
            },
            validator: (value){
              if(value!=null && value.isEmpty){
                return "This field is obligatory";
              }
            },            
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Phone", icon: Icon(Icons.phone)),
            onSaved: (value){
              phoneValue = value;
            },                        
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Location", icon: Icon(Icons.add_location_alt)),
            onSaved: (value){
              locationValue = value;
            },
            validator: (value){
              if(value!=null && value.isEmpty){
                return "This field is obligatory";
              }
            },            
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Languages", icon: Icon(Icons.chat_bubble_outline)),
            onSaved: (value){
              languagesValue = value;
            },
            validator: (value){
              if(value!=null && value.isEmpty){
                return "This field is obligatory";
              }
            },            
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              child: Text("Register"),
              onPressed: (){
                _register();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _register(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    }
  }
  
}