import 'package:flutter/material.dart';
import 'package:petcare_app/logged_pages/angel_screen.dart';
import 'package:petcare_app/pedidos/pedidos.dart';

class PedidosTile extends StatelessWidget {

  final Pedidos pedido;
  BuildContext context;
  PedidosTile(this.context, this.pedido);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>AngelScreen(pedido))
        );
      },
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/pegada.png'),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pedido.anjo.length > 20 ?
                        Text(pedido.anjo.substring(0,20)+"...", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),) :
                        Text(pedido.anjo, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                    pedido.objetivo.length > 20 ?
                        Text("Objetivo: "+ pedido.objetivo.substring(0,20)+"...", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),):
                        Text("Objetivo: "+ pedido.objetivo, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),),

                    pedido.endereco.length > 20 ?
                        Text("Local: "+ pedido.endereco.substring(0,20)+"...", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),):
                        Text("Local: "+ pedido.endereco, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
