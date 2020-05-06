import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:petcare_app/pedidos/pedidos.dart';
import 'package:petcare_app/pedidos/pedidos_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  TextEditingController _searchController = TextEditingController();
  String filter;
  List<Pedidos> pedidos;

  @override
  void initState(){
    _searchController.addListener((){
      setState(() {
        filter = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<Null> carregaPedidos()async{
    //Iniciando a lista com os pedidos cadastrados
    QuerySnapshot query = await Firestore.instance.collection("pedidos").getDocuments();
    pedidos = query.documents.map((doc)=>Pedidos.fromDocuments(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
      child: Scaffold(
        body: SingleChildScrollView(
          child: ScopedModelDescendant<UserModel>(
            builder: (context, child, model){
              carregaPedidos();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.orange,),
                        hintText: "Pesquise por algum pedido",
                        helperText: "Ex: Alupurinol, Shopping tal"
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  StreamBuilder(
                    stream: Firestore.instance.collection("pedidos").snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData || snapshot.data.documents.length == 0 || snapshot.data == null){
                        print(pedidos.length.toString());
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
                      }else {
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(12),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              print(pedidos[index].medicamento);
                              return filter == null || filter == "" ?
                                PedidosTile(context, Pedidos.fromDocuments(snapshot.data.documents[index])) :
                                  pedidos[index].medicamento.toLowerCase().contains(filter.toLowerCase()) ?
                                    PedidosTile(context, Pedidos.fromDocuments(snapshot.data.documents[index])) : new Container();
                              //return PedidosTile(context, Pedidos.fromDocuments(snapshot.data.documents[index]));
                            }
                        );
                      }
                    }
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

}
