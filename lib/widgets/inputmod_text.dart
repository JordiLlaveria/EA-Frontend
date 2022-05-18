import 'package:flutter/material.dart';

class InputModText extends StatelessWidget {
  final String label;
  final String hint;
  final Icon icon;
  final TextInputType keyboard;
  final bool obsecure;
  final void Function( String data) onChanged;

  const InputModText({ Key? key,
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
        decoration: InputDecoration(
          hintText: this.hint,
          labelText: this.label,
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontFamily: 'FredokaOne',
            fontSize: 15.0
          ),
          suffixIcon: this.icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          )
        ),
      ),
    );
  }
}