import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:petcare_app/pedidos/pedidos.dart';
import 'package:scoped_model/scoped_model.dart';

class PedidosModel extends Model{
  UserModel user;
  List<Pedidos> pedidos = [];
  Map<String, dynamic> pedidosData = Map();

  PedidosModel();
  PedidosModel.user(this.user);
  static PedidosModel of(BuildContext context) => ScopedModel.of<PedidosModel>(context);

  /*
  Função para adicionar o pedido a lista de pedidos do
  usuário.
  @param: pedido
  @result: nenhum
   */
  void addPedidoPessoal(Pedidos pedido, String userId){
    pedidos.add(pedido);
    Firestore.instance.collection("usuarios").document(userId)
      .collection("pedidosFeitos").add(pedido.toMap()).then((doc){
       pedido.id = doc.documentID;
    });
    notifyListeners();
  }

  /*
  Função para adicionar o pedido a lista de pedidos do
  banco de dados.
  @param: pedido
  @result: Future nulo
   */
  Future<Null> addPedido({@required Map<String, dynamic> pedidosData}) async{
    this.pedidosData = pedidosData;
    await Firestore.instance.collection("pedidos").document().setData(pedidosData);
  }
  
}