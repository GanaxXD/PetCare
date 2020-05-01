import 'package:flutter/material.dart';
import 'package:petcare_app/pedidos/pedidos.dart';
import 'package:petcare_app/logged_pages/angel_screen.dart';

class CardAngel extends StatelessWidget {

 /* String angel, objective, place, medicine;
  CardAngel({this.angel, this.objective, this.place, this.medicine});
*/

 Pedidos pedido;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>AngelScreen(pedido))
        );
      },
      child: Container(
        height: 150,
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(10),
          borderOnForeground: true,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.favorite, color: Colors.orange, size: 40,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top:0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(this.pedido.anjo.length > 20 ? this.pedido.anjo.substring(0, 20) + "..." : this.pedido.anjo, style: TextStyle(
                        color: Colors.black45,
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                      ), overflow: TextOverflow.ellipsis,),

                    Text(this.pedido.objetivo.length > 20 ? this.pedido.objetivo.substring(0,20) +"..." :this.pedido.objetivo, style: TextStyle(
                          color: Colors.black26,
                          fontSize: 16,
                      ), overflow: TextOverflow.ellipsis, maxLines: 1,),

                    Text(this.pedido.medicamento.length > 20 ? this.pedido.medicamento.substring(0,20) +"..." : this.pedido.medicamento, style: TextStyle(
                      color: Colors.black26,
                      fontSize: 16,
                    ), overflow: TextOverflow.ellipsis, maxLines: 1,),

                   Text(this.pedido.endereco.length >20 ? this.pedido.endereco.substring(0,20) + "..." : this.pedido.endereco, style: TextStyle(
                            color: Colors.black26,
                            fontSize: 16,
                          ),
                            overflow: TextOverflow.ellipsis, maxLines: 1,
                    ),
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
