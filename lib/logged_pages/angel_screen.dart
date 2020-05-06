import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare_app/logged_pages/logged_screen.dart';
import 'package:petcare_app/pedidos/edit_screen.dart';
import 'package:petcare_app/pedidos/pedidos.dart';
import 'package:petcare_app/widgets/circular_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 20.0, bottom: 10),
                  child: Text(this.pedido.anjo,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 20, right: 10),
                  child: pedido.concluido == true ?
                    Icon(Icons.check, color: Colors.green, size: 40,):
                    Icon(Icons.check, color: Colors.grey[600], size: 40,)
                ),
              ],
            ),
            Divider(color: Colors.deepOrange,),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(pedido.concluido==true ? "Pedido atendido: Sim": "Pedido atendido: Não",
                  style: TextStyle(
                  color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                ),),
              ],
            ),

            SizedBox(height: 10,),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Data do pedido: ", style: TextStyle(
                    color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                ),),
                Text(DateFormat("dd/MM/yyy").format(DateTime.fromMicrosecondsSinceEpoch(inicio)).toString(), style: TextStyle(
                    color: Colors.black45, fontSize: 16, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Objetivo: ", style: TextStyle(
                    color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                ),),
                Text(pedido.objetivo, style: TextStyle(
                    color: Colors.black45, fontSize: 16, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Nome do pet: ", style: TextStyle(
                    color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                ),),
                Text(pedido.pet, style: TextStyle(
                    color: Colors.black45, fontSize: 16, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Sexo: ", style: TextStyle(
                    color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                ),),
                Text(pedido.sexoPet, style: TextStyle(
                    color: Colors.black45, fontSize: 16, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: <Widget>[
                Text("Medicamento: ", style: TextStyle(
                    color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                ),),
                Text(pedido.medicamento, style: TextStyle(
                    color: Colors.black45, fontSize: 16, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Me contacte pelo Instagram: ", style: TextStyle(
                    color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                ),),
                Text(pedido.contato.toString(), style: TextStyle(
                    color: Colors.black45, fontSize: 16, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Me contacte pelo Facebook: ", style: TextStyle(
                    color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                ),),
                Text(pedido.facebook, style: TextStyle(
                    color: Colors.black45, fontSize: 16, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Número para contato: ", style: TextStyle(
                    color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                ),),
                Text(pedido.numero.toString(), style: TextStyle(
                    color: Colors.black45, fontSize: 16, fontWeight: FontWeight.normal
                ),),
              ],
            ),

            SizedBox(height: 10,),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: <Widget>[
                Text("Onde me encontrar: ", style: TextStyle(
                    color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                ),),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(pedido.endereco, style: TextStyle(
                      color: Colors.black54, fontSize: 16, fontWeight: FontWeight.normal
                  ), textAlign: TextAlign.center,),
                ),
              ],
            ),

            SizedBox(height: 10,),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: CircularButton(
                    colorText: Colors.white,
                    backgroundColor: Colors.orange,
                    title: "Finalizar Pedido",
                    onPressed: (){
                      return Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "Finalizar Pedido?",
                          desc: "Deseja Finalizar o pedido criado? Ao finalizá-lo,"
                              " o sistema entenderá que você já entrou em contato com a dono "
                              "deste chamado e já entrou em um acordo com o mesmo.",
                          buttons: [
                            DialogButton(
                                color: Colors.orange,
                                child: Text("Finalizar", style:
                                TextStyle(color: Colors.white, fontSize: 20,)),
                                onPressed: () async {
                                  print(pedido.id);
                                  await Firestore.instance.collection("pedidos").document(pedido.id).setData({
                                    "concluido": true,
                                  }, merge: true).then((_){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => LoggedScreen()
                                    ));
                                  }).catchError((e){
                                    print(e.toString());
                                  });

                                }
                            ),
                            DialogButton(
                              color: Colors.orange,
                              child: Text("Cancelar", style:
                              TextStyle(color: Colors.white, fontSize: 20,)),
                              onPressed: () => Navigator.pop(context),
                            )
                          ]
                      ).show();
                    },
                  ),
                ),
              ],
            ),

          ],
        ),
    );
  }

}
