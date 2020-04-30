import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {

  String hint, label, helper;
  Icon icon;
  bool obscure;
  TextEditingController controller;
  Function validate, onSaved;

  FormFields({this.label, this.icon, this.hint, this.helper, this.obscure, this.controller, this.validate, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(0),
      child: TextFormField(
        cursorColor: Colors.orange,
        obscureText: obscure,
        controller: controller,
        validator: validate,
        onSaved: onSaved,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          helperText: helper,
          contentPadding: const EdgeInsets.all(12),
          labelStyle: TextStyle(color: Colors.orange),
          hintStyle: TextStyle(color: Colors.orange[400]),
          helperStyle: TextStyle(color: Colors.orangeAccent),
        ),

      ),
    );
  }
}
