import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hint;
  final Icon icon;
  final TextInputType keyboard;
  final bool obsecure;
  final void Function( String data) onChanged;

  const InputText({ Key? key,
          this.label = '',
          this.hint = '',
          required this.icon,
          this.keyboard = TextInputType.text,
          this.obsecure = false,
          required this.onChanged}) 
         : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: this.keyboard,
        obscureText: this.obsecure,
        onChanged:  this.onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: this.hint,
          labelText: this.label,
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 238, 241, 243),
            fontFamily: 'FredokaOne',
            fontSize: 15.0
          ),
          suffixIcon: this.icon,
          suffixIconColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.circular(20.0),
          ),
          errorStyle: TextStyle(color: Colors.white)
        ),   
      ),
    );
  }
}