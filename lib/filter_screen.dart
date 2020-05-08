import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:petcare_app/pedidos/pedidos.dart';
import 'package:petcare_app/pedidos/pedidos_model.dart';
import 'package:petcare_app/pedidos/pedidos_tile.dart';
import 'package:petcare_app/pesquisa/cardPesquisa.dart';
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
                      controller: _searchController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.orange,),
                        hintText: "Pesquise por algum medicamento, local ou nome do Pet",
                        helperText: "Ex: Alupurinol, Shopping tal, Scooby",
                        labelText: "Faça uma pesquisa: ",
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  StreamBuilder<QuerySnapshot>(
                    stream:  Firestore.instance.collection("pedidos").snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData || snapshot.data.documents.isEmpty || snapshot.data == null){
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
                            reverse: false,
                            padding: const EdgeInsets.all(12),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              print(pedidos[index].medicamento);
                              return filter == null || filter == ""?
                                CardPesquisa(context, Pedidos.fromDocuments(snapshot.data.documents[index])) :
                                  pedidos[index].objetivo.toLowerCase().contains(filter.toLowerCase())
                                      || pedidos[index].medicamento.toLowerCase().contains(filter.toLowerCase())
                                      || pedidos[index].pet.toLowerCase().contains(filter.toLowerCase()) 
                                      || pedidos[index].endereco.toLowerCase().contains(filter.toLowerCase())
                                      || pedidos[index].anjo.toLowerCase().contains(filter.toLowerCase())
                                      || pedidos[index].contato.toLowerCase().contains(filter.toLowerCase())
                                      || pedidos[index].facebook.toLowerCase().contains(filter.toLowerCase())?
                                    CardPesquisa(context, pedidos[index]) :
                                    Container(
                                      height: MediaQuery.of(context).size.height, //Para que apareça apenas uma mensagem em resposta
                                      width: MediaQuery.of(context).size.width*0.8,
                                      padding: const EdgeInsets.all(10),
                                      child: Text("Sem resultados para a busca.", style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 12
                                      ), textAlign: TextAlign.center,),
                                    );
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
