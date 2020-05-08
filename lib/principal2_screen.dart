import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:petcare_app/pedidos/pedidos.dart';
import 'package:petcare_app/pedidos/pedidos_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class PrincipalScreen2 extends StatefulWidget {
  @override
  _PrincipalScreen2State createState() => _PrincipalScreen2State();
}

class _PrincipalScreen2State extends State<PrincipalScreen2> {

  List<Pedidos> pedidos;

  Future<QuerySnapshot> carregaPedidos() async {
    QuerySnapshot query = await Firestore.instance.collection("pedidos").getDocuments();
    pedidos = query.documents.map((doc)=> Pedidos.fromDocuments(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    carregaPedidos();
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Anjo: ", style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          ),),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: model.userData.isEmpty ? Text("Usuário"):
                            Text(model.userData["usuario"].toString().length > 20 ?
                            model.userData["usuario"].toString().substring(0,20)+"...":
                            model.userData["usuario"],
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text("Contato: ", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: model.userData.isEmpty ? Text("Contato"):
                            Text(model.userData["contato"].toString().length > 15 ?
                            model.userData["contato"].toString().substring(0,15)+"...":
                            model.userData["contato"],
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
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
                        print("INDEX: "+snapshot.data.documents.length.toString());
                        print("TEM DATA? "+snapshot.hasData.toString());
                        print("É NULO? "+snapshot.data.toString());
                        if(!snapshot.hasData || snapshot.data == null || snapshot.data.documents.length < 0){
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/dog.png', color: Colors.orangeAccent,
                                  height: 25, width: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text("Sem pedidos cadastrados.",
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(12),
                            //ignore: missing_return
                            itemBuilder: (context, index) {
                              print("TAMANHO DA LISTA: "+pedidos.length.toString());
                              print("PEDIDOS: "+pedidos[index].concluido.toString());
                              print("DOCUMENT[INDEX]"+snapshot.data.documents[index]["concluido"]);
                              if(snapshot.data.documents[index]["concluido"].toString().contains("N")){
                                print("INDEX: "+index.toString());
                                print("DOCUMENT[INDEX][CONCLUIDO]: "+snapshot.data.documents[index]["concluido"]); //Pedidos.fromDocuments(snapshot.data.documents[index])
                                return PedidosTile(context, Pedidos.fromDocuments(snapshot.data.documents[index]), model.firebaseUser.uid);
                              } else{
                                return Container(
                                  height: MediaQuery.of(context).size.height,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/dog.png', color: Colors.orangeAccent,
                                        height: 25, width: 25,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("Sem pedidos disponíveis.",
                                          style: TextStyle(
                                              color: Colors.deepOrange,
                                              fontSize: 14
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
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
