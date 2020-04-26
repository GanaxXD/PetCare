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
        child: SingleChildScrollView(
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
                height: MediaQuery.of(context).size.height*0.4,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.orangeAccent,
                ),
              ),

              SizedBox(height: 10,),

              //Informações do objeto selecionado
              Divider(color: Colors.deepOrange,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Anjo:", style: TextStyle(
                    color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w500,
                  ),),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 4),
                    child: Text("Pegar do firebase o nome do ajudante", style: TextStyle(
                      color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w300,
                    ), overflow: TextOverflow.ellipsis,),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Pet:", style: TextStyle(
                    color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w500,
                  ),),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 4),
                    child: Text("Pegar do firebase", style: TextStyle(
                      color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w300,
                    ), overflow: TextOverflow.ellipsis,),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Medicamento:", style: TextStyle(
                    color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w500,
                  ),),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 4),
                    child: Text("Pegar do firebase", style: TextStyle(
                      color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w300,
                    ), overflow: TextOverflow.ellipsis,),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Local de encontro:", style: TextStyle(
                    color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w500,
                  ),),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 4),
                    child: Text("Pegar do firebase", style: TextStyle(
                      color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w300,
                    ), overflow: TextOverflow.ellipsis,),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
