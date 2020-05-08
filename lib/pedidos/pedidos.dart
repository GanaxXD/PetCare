import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Pedidos{
  String anjo, objetivo, medicamento, pet, sexoPet, endereco, id, numero,
      contato, facebook, idMeuChamado, chave, usuario_do_chamado, concluido;
 // bool concluido;
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
    usuario_do_chamado = snapshot.data["usuario_do_chamado"];
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
      "instagram" : contato,
      "numero" : numero,
      "facebook" : facebook,
      "id_do_chamado": idMeuChamado,
      "id" : id,
      "chave": chave,
      "usuario_do_chamado" : usuario_do_chamado,
    };
  }
}