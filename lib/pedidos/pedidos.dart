import 'package:cloud_firestore/cloud_firestore.dart';

class Pedidos{
  String anjo, objetivo, medicamento, pet, sexoPet, endereco, id, numero, contato, facebook;
  bool concluido;
  Timestamp dataDoPedido;

  Pedidos();

  Pedidos.fromDocuments(DocumentSnapshot snapshot){
    anjo = snapshot.data["usuario"];
    objetivo = snapshot.data["objetivo"];
    medicamento = snapshot.data["medicamento"];
    pet = snapshot.data["nomepet"];
    sexoPet = snapshot.data["sexopet"];
    endereco = snapshot.data["endereco"];
    concluido = snapshot.data["concluido"];
    dataDoPedido = snapshot.data["data_do_pedido"];
    numero= snapshot.data["numero"];
    contato = snapshot.data["contato"];
    id = snapshot.documentID;
    facebook = snapshot.data["facebook"];
  }

  Map<String, dynamic> toMap(){
    return {
      "usuario": anjo,
      "objetivo" : objetivo,
      "medicamento" : medicamento,
      "nomepet": pet,
      "sexopet": sexoPet,
      "endereco": endereco,
      "concluido": concluido,
      "data_do_pedido": dataDoPedido,
      "contato" : contato,
      "numero" : numero,
      "facebook" : facebook,
    };
  }
}