import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare_app/pedidos/pedidos.dart';

//Tela de pedidos
class AngelScreen extends StatelessWidget {

  Pedidos pedido;
  AngelScreen(this.pedido);

  @override
  Widget build(BuildContext context) {
    var inicio = pedido.dataDoPedido.microsecondsSinceEpoch;

    return Scaffold(
        appBar: AppBar(
          title: Text("Pedido"),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Text(this.pedido.anjo,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(color: Colors.deepOrange,),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(pedido.concluido==true ? "Pedido atendido: Sim": "Pedido atendido: Não",
                  style: TextStyle(
                  color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Data do pedido: ", style: TextStyle(
                    color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold
                ),),
                Text(DateFormat("dd/MM/yyy").format(DateTime.fromMicrosecondsSinceEpoch(inicio)), style: TextStyle(
                    color: Colors.black45, fontSize: 12, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Objetivo: ", style: TextStyle(
                    color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold
                ),),
                Text(pedido.objetivo, style: TextStyle(
                    color: Colors.black45, fontSize: 12, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Nome do pet: ", style: TextStyle(
                    color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold
                ),),
                Text(pedido.pet, style: TextStyle(
                    color: Colors.black45, fontSize: 12, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Sexo: ", style: TextStyle(
                    color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold
                ),),
                Text(pedido.sexoPet, style: TextStyle(
                    color: Colors.black45, fontSize: 12, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Medicamento: ", style: TextStyle(
                    color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold
                ),),
                Text(pedido.medicamento, style: TextStyle(
                    color: Colors.black45, fontSize: 12, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Me contacte por: ", style: TextStyle(
                    color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold
                ),),
                Text(pedido.contato, style: TextStyle(
                    color: Colors.black45, fontSize: 12, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Número para contato: ", style: TextStyle(
                    color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold
                ),),
                Text(pedido.numero.isEmpty ? "Sem número cadastrado" : pedido.numero.toString(), style: TextStyle(
                    color: Colors.black45, fontSize: 12, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            SizedBox(height: 10,),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                Text("Onde me encontrar: ", style: TextStyle(
                    color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold
                ),),
                Text(pedido.endereco, style: TextStyle(
                    color: Colors.black54, fontSize: 12, fontWeight: FontWeight.normal
                ),overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

          ],
        ),
    );
  }
}
