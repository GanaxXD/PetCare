import 'package:flutter/material.dart';
import 'package:petcare_app/logged_pages/widgets/cardAngel.dart';

class ListAngelsScreen extends StatefulWidget {
  @override
  _ListAngelsScreenState createState() => _ListAngelsScreenState();
}

class _ListAngelsScreenState extends State<ListAngelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CardAngel(
              angel: "Pedro",
              objective: "Pedir Medicamento",
              medicine: "Alupurinol",
              place: "Shopping da Ilha, atras do coleoaisjisjadijasoidjoaisjdoiasjfijadijfiadjflijadlifjl asfoijadifjlkadj",
            ),
          ],
        )
      ),
    );
  }
}
