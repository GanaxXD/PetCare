import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Localize aqui um ajudante para o seu pet", style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w600,
              fontSize: 16
          ),overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10,),
          //No lugar desse container ficará o mapa
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.orangeAccent,
            ),
          ),

        ],
      ),
    );
  }
}
