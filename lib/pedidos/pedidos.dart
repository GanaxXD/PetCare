import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Pedidos{
  String anjo, objetivo, medicamento, pet, sexoPet, endereco, id, numero, contato, facebook, idMeuChamado, chave;
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
    contato = snapshot.data["instagram"];
    id = snapshot.data["usuario"]+snapshot.data["chave"].toString();
    idMeuChamado = snapshot.documentID;
    facebook = snapshot.data["facebook"];
    chave = snapshot.data["chave"];
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
      "id_do_chamado": idMeuChamado,
      "id" : id,
      "chave": chave,
    };
  }
}