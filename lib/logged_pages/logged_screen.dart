import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petcare_app/logged_pages/cadastrar_screen.dart';
import 'package:petcare_app/logged_pages/principal_screen.dart';

class LoggedScreen extends StatefulWidget {
  @override
  _LoggedScreenState createState() => _LoggedScreenState();
}

class _LoggedScreenState extends State<LoggedScreen> {

  int indexTela = 0;

  //Mudando as telas
  void mudandoTelas(int index){
    setState(() {
      indexTela = index;
    });
  }

  //Lista de ícones
  final bottomNavigationBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.orange,), title: Text("Tela Principal", style: TextStyle(color: Colors.orange),)),
    BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline, color: Colors.orange,), title: Text("Cadastrar Pet", style: TextStyle(color: Colors.orange),)),
    BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted, color: Colors.orange,), title: Text("Lista de Anjos", style: TextStyle(color: Colors.orange),)),
  ];

  //Lista de Telas
  final screens = <Widget>[
    Principal(),
    Cadastrar(),
    Container(color: Colors.white,),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
      child: Scaffold(
        appBar: AppBar(
          title: Text("PET CARE"),
          centerTitle: true,
          backgroundColor: Colors.orange,
          actions: <Widget>[
            Row(
              children: <Widget>[
                Text("SAIR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                IconButton(
                    icon: Icon(Icons.exit_to_app, color: Colors.white,),
                    onPressed: () => exit(0), //da library dart.io

                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: bottomNavigationBar,
          currentIndex: indexTela,
          onTap: mudandoTelas,
        ),
        body:screens[indexTela],
      ),
    );
  }
}
