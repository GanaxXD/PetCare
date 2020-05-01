import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {

  String hint, label, helper;
  Icons icon;
  bool obscure;
  TextEditingController controller;
  Function validate, onSaved;

  FormFields({this.label, this.icon, this.hint, this.helper, this.obscure, this.controller, this.validate, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        helperText: helper,
        contentPadding: const EdgeInsets.all(12),
        labelStyle: TextStyle(color: Colors.orange),
        hintStyle: TextStyle(color: Colors.orange[400]),
        helperStyle: TextStyle(color: Colors.orangeAccent)
      ),
      cursorColor: Colors.orange,
      obscureText: obscure,
      controller: controller,
      validator: validate,
      onSaved: onSaved,

    );
  }
}
