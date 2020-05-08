import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_app/pedidos/meus_pedidos_tile.dart';
import 'package:petcare_app/pedidos/pedidos.dart';

class MyCallsScreen extends StatefulWidget {

  String uid;
  MyCallsScreen(this.uid);

  @override
  _MyCallsScreenState createState() => _MyCallsScreenState(this.uid);
}

class _MyCallsScreenState extends State<MyCallsScreen> {

  String uid;
  _MyCallsScreenState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.loose,
          overflow: Overflow.clip,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Legenda:", style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: Colors.black54
                ),),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        color: Colors.green,
                        height: 5,
                        width: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text ("Atendido", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black54
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        color: Colors.redAccent,
                        height: 5,
                        width: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text ("Em aberto", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black54
                      ),),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder(
                  stream: Firestore.instance.collection("usuarios").document(this.uid).collection("pedidosFeitos").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot == null || snapshot.data.documents.length == 0){
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
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          return MeusPedidosTile(context, Pedidos.fromDocuments(snapshot.data.documents[index]), uid);
                        },
                      );
                    }
                  }
                ),
          ],
        ),
      ),
    );
  }
}
