import 'package:flutter/material.dart';

class CadastroFormField extends StatelessWidget {

  String hint, helper, label, initialValue;
  Function onSaved, validate;
  Icon icon;
  TextEditingController controller;

  CadastroFormField({this.label, this.hint, this.helper, this.validate, this.onSaved, this.icon, this.controller, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.orange,
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.orange[400],
        ),
        helperStyle: TextStyle(color: Colors.orange,),
        labelStyle: TextStyle(color: Colors.orange),
        hintText: hint,
        helperText: helper,
        icon: icon,
        labelText: label,
      ),
      controller: controller,
      //initialValue: initialValue.toString(),

    );
  }
}

