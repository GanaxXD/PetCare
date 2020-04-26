import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {

  final String title;
  final Color colorText, backgroundColor;
  final Function onPressed;

  CircularButton({this.title, this.colorText, this.backgroundColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: onPressed,
            color: backgroundColor,
            splashColor: Colors.orange,
            child: Text("$title", style: TextStyle(
              color: colorText,
              fontSize: 16
            ),),
    );
  }
}
