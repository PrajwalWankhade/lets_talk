import 'package:flutter/material.dart';


class customTextField extends StatelessWidget {
  const customTextField({Key? key, required this.text, required this.onChanged, required this.isPassword, required this.keyboardtype, required this.icon})
      : super(key: key);

  final String text;
  final ValueChanged<String> onChanged;
  final bool isPassword;
  final TextInputType keyboardtype;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardtype,
      onChanged: onChanged,
      obscureText: isPassword,

      decoration: InputDecoration(
        hintText: text,
        prefixIcon: icon,

      ),
    );
  }
}