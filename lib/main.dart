import 'package:flutter/material.dart';
import 'package:petcare_app/login/login_screen.dart';
import 'package:petcare_app/widgets/circular_button.dart';

void main(){
  runApp(MaterialApp(
    title: "Pet Care",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.withAlpha(150),
      appBar: AppBar(
        title: Text("Ajude um pet",),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),

          Text("PET CARE", style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ), textAlign: TextAlign.center,),

          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 0),
            child: Image.asset('assets/petCare-inicio.png',
              height: MediaQuery.of(context).size.height *0.5,
              width: MediaQuery.of(context).size.width *0.5,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularButton(
              title: "Entrar",
              backgroundColor: Colors.orange,
              colorText: Colors.white,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreen()
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

