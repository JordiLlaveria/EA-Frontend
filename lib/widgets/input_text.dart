import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hint;
  final Icon icon;
  final TextInputType keyboard;
  final bool obsecure;
  final void Function(String data) onChanged;

  const InputText(
      {Key? key,
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
        onChanged: this.onChanged,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
            hintText: this.hint,
            labelText: this.label,
            labelStyle: TextStyle(
                color: Color.fromARGB(255, 238, 241, 243),
                fontFamily: 'FredokaOne',
                fontSize: 15.0),
            suffixIcon: this.icon,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      ),
    );
  }
}
