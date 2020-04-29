import 'package:flutter/material.dart';
import 'package:petcare_app/logged_pages/home_screen.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: "Pet Care",
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
