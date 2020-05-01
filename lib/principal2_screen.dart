import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:petcare_app/pedidos/pedidos.dart';
import 'package:petcare_app/pedidos/pedidos_model.dart';
import 'package:petcare_app/pedidos/pedidos_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class PrincipalScreen2 extends StatefulWidget {
  @override
  _PrincipalScreen2State createState() => _PrincipalScreen2State();
}

class _PrincipalScreen2State extends State<PrincipalScreen2> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        return WillPopScope(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Cabeçalho
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Anjo: ", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14
                          ),),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: model.userData.isEmpty ? Text("Usuário"):
                            Text(model.userData["usuario"].toString().length > 50 ?
                              model.userData["usuario"].toString().substring(0,50)+"...":
                              model.userData["usuario"],
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w200
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(top: 0, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Contato: ", style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          ),),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: model.userData.isEmpty ? Text("Contato"):
                            Text(model.userData["contato"].toString().length > 50 ?
                            model.userData["contato"].toString().substring(0,50)+"...":
                            model.userData["contato"],
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(color: Colors.deepOrange,),

                    //Pedidos
                    Text("Pedidos", style: TextStyle(
                      color: Colors.black26,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ), textAlign: TextAlign.center,),

                    SizedBox(height: 20,),

                    //Pedidos do banco de dados
                    StreamBuilder(
                      stream: Firestore.instance.collection("pedidos").snapshots(),
                      // ignore: missing_return
                      builder: (context, snapshot){
                        if(!snapshot.hasData || snapshot == null){
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/dog.png', color: Colors.orangeAccent,
                                    height: 16, width: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text("Sem pedidos cadastrados.",
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 12
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            reverse: true,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(12),
                            //ignore: missing_return
                            itemBuilder: (context, index){
                              if(snapshot.data.documents[index]["concluido"] == false){
                                return PedidosTile(context, Pedidos.fromDocuments(snapshot.data.documents[index]));
                              } else {
                                Text("");
                              }
                            },
                          );
                        }
                      },

                    ),
                  ],
                ),
              ),
            ),
            onWillPop: (){}
        );
      },
    );
  }
}
