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
  Stream stream, nomeStream, medicamentoStream, localStream, inicialData;

  @override
  void initState(){
    _searchController.addListener((){
      setState(() {
        filter = _searchController.text;
      });
    });
    medicamentoStream = Firestore.instance.collection("pedidos").orderBy("medicamento", descending: false).snapshots();
    nomeStream = Firestore.instance.collection("pedidos").orderBy("nomepet", descending: false).snapshots();
    localStream = Firestore.instance.collection("pedidos").orderBy("endereco", descending: false).snapshots();
    inicialData = null;
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
    //stream = Firestore.instance.collection("pedidos").snapshots();
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Ordenar Pedidos: ", style: TextStyle(color: Colors.grey[700], fontSize: 14, fontWeight: FontWeight.w900),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.sort_by_alpha, color: Colors.grey[800],),
                                      onPressed: (){
                                        setState(() {
                                          //stream = Firestore.instance.collection("pedidos").orderBy("medicamento", descending: false).snapshots();
                                          inicialData = Firestore.instance.collection("nenhum").snapshots();
                                          stream = medicamentoStream;
                                        });
                                      }
                                  ),
                                  Text("Medicamentos A-Z", style: TextStyle(fontSize: 12),)
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.sort_by_alpha, color: Colors.grey[800],),
                                      onPressed: (){
                                        setState((){
                                          inicialData = Firestore.instance.collection("nenhum").snapshots();
                                          stream = nomeStream;
                                        });
                                      }
                                  ),
                                  Text("Nome do Pet A-Z", style: TextStyle(fontSize: 12),)
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.sort_by_alpha, color: Colors.grey[800],),
                                      onPressed: (){
                                        setState(() {
                                          inicialData = Firestore.instance.collection("nenhum").snapshots();
                                          stream = localStream;
                                        });
                                      }
                                  ),
                                  Text("Local A-Z", style: TextStyle(fontSize: 12),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                  StreamBuilder(
                    stream:  stream,
                    initialData: inicialData,
                    builder: (context, snapshot) {
                      if(inicialData == null){
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(20),
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height*0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    Text("Clique em \num dos \nmeios de ordenação.",
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 20
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      }

                      if(!snapshot.hasData || snapshot.data.documents.isEmpty){
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
                                      || pedidos[index].medicamento.toString().toLowerCase().contains(filter.toLowerCase())
                                      || pedidos[index].pet.toLowerCase().contains(filter.toLowerCase()) 
                                      || pedidos[index].endereco.toLowerCase().contains(filter.toLowerCase()) ?
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
