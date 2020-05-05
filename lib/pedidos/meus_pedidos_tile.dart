import 'package:flutter/material.dart';
import 'package:petcare_app/pedidos/meus_pedidos_screen.dart';
import 'package:petcare_app/pedidos/pedidos.dart';

class MeusPedidosTile extends StatelessWidget {

  final Pedidos pedido;
  String uid;
  BuildContext context;
  MeusPedidosTile(this.context, this.pedido, this.uid);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>MeusPedidosScreen(this.pedido, this.uid))
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
                    pedido.pet.length > 20 ?
                    Text(pedido.pet.substring(0,20)+"...", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),) :
                    Text(pedido.pet, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

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
