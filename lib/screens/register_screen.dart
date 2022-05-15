import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey =  GlobalKey<FormState>();
  final nameController = new TextEditingController();
  final surnameController = new TextEditingController();
  final usernameController = new TextEditingController();
  final password1Controller = new TextEditingController();
  final password2Controller = new TextEditingController();
  final emailController = new TextEditingController();
  final phoneController = new TextEditingController();
  final locationController = new TextEditingController();
  final languagesController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      validator: (value){
        if(value!.isEmpty){
          return "This field is obligatory";
        }
      },
      onSaved: (value){
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_box),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final surnameField = TextFormField(
      autofocus: false,
      controller: surnameController,
      keyboardType: TextInputType.name,
      validator: (value){
        if(value!.isEmpty){
          return "This field is obligatory";
        }
      },
      onSaved: (value){
        surnameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_box_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Surname",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final usernameField = TextFormField(
      autofocus: false,
      controller: usernameController,
      keyboardType: TextInputType.name,
      validator: (value){
        if(value!.isEmpty){
          return "This field is obligatory";
        }
      },
      onSaved: (value){
        usernameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.sentiment_satisfied),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final password1Field = TextFormField(
      autofocus: false,
      controller: password1Controller,
      obscureText: true,
      validator: (value){
        if(value!.isEmpty){
          return "This field is obligatory";
        }
      },
      onSaved: (value){
        password1Controller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final password2Field = TextFormField(
      autofocus: false,
      controller: password2Controller,
      obscureText: true,
      validator: (value){
        if(value!.isEmpty){
          return "This field is obligatory";
        }
      },
      onSaved: (value){
        password2Controller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return "This field is obligatory";
        }
      },
      onSaved: (value){
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final phoneField = TextFormField(
      autofocus: false,
      controller: phoneController,
      keyboardType: TextInputType.phone,      
      onSaved: (value){
        phoneController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Phone",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final locationField = TextFormField(
      autofocus: false,
      controller: locationController,
      keyboardType: TextInputType.number,
      validator: (value){
        if(value!.isEmpty){
          return "This field is obligatory";
        }
      },
      onSaved: (value){
        locationController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.add_location_alt),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "[Longitude],[Latitude]",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final languagesField = TextFormField(
      autofocus: false,
      controller: languagesController,
      keyboardType: TextInputType.text,
      validator: (value){
        if(value!.isEmpty){
          return "This field is obligatory";
        }
      },
      onSaved: (value){
        languagesController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.chat_bubble_outline),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Languages",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final registerButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
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
      
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child:Padding(
              padding: const EdgeInsets.all(36),
              child: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      "REGISTER",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                    ),
                    SizedBox(height: 20),
                    nameField,
                    SizedBox(height: 20),
                    surnameField,
                    SizedBox(height: 20),
                    usernameField,
                    SizedBox(height: 20),
                    password1Field,
                    SizedBox(height: 20),
                    password2Field,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    phoneField,
                    SizedBox(height: 20),
                    locationField,
                    SizedBox(height: 20),
                    languagesField,
                    SizedBox(height: 20),
                    registerButton,
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),            
          ),
        ),
      ),
    );
  }

  void _register(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    }
  }
}