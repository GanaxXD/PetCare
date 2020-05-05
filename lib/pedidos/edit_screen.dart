import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_app/logged_pages/widgets/cadastro_form_field.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:petcare_app/my_calls%20_screen.dart';
import 'package:petcare_app/pedidos/pedidos.dart';
import 'package:petcare_app/pedidos/pedidos_model.dart';
import 'package:petcare_app/widgets/circular_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';

class EditScreen extends StatefulWidget {

  Pedidos pedido;
  String uid;
  EditScreen(this.pedido, this.uid);

  @override
  _EditScreenState createState() => _EditScreenState(this.pedido, this.uid);
}

class _EditScreenState extends State<EditScreen> {

  Pedidos pedido;
  String uid;
  _EditScreenState(this.pedido, this.uid);

  int sexo;
  int objetivo;
  final int macho =1, femea =0;
  final int receber = 1, doar = 0, abandonado = 2;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _nomePetController = TextEditingController();
  TextEditingController _localPetController = TextEditingController();
  TextEditingController _contatoPetController = TextEditingController();
  TextEditingController _facebookController = TextEditingController();
  TextEditingController _numeroPetController = TextEditingController();
  TextEditingController _medicamentoController = TextEditingController();


  @override
  void dispose() {
    _nomePetController.dispose();
    _localPetController.dispose();
    _contatoPetController.dispose();
    _facebookController.dispose();
    _numeroPetController.dispose();
    _medicamentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sexo = this.pedido.sexoPet.toLowerCase() == "macho" ? 1 : 0;
    if(pedido.objetivo.toLowerCase() == "receber redicamento"){
      objetivo = 1;
    } else if (pedido.objetivo.toLowerCase() == "doar medicamento"){
      objetivo = 0;
    } else if (pedido.objetivo.toLowerCase() == "indicar abandono"){
      objetivo = 2;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Editar Pedido"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: ScopedModelDescendant<UserModel>(
            builder: (context, child, model){
              return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min, //Para os campos filhos da coluna que sejam flexible e expanded possa aparecer na tela
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text("NÃO É NECESSÁRIO PREENCHER TODOS OS CAMPOS. "
                                "PREENCHA SOMENTE OS CAMPOS QUE DESEJA MODIFICAR. OS CAMPOS QUE VOCÊ NÃO "
                                "DESEJA MODIFICAR DEIXE EM BRANCO.", style: TextStyle(
                              color: Colors.deepOrange, fontSize: 16, fontWeight: FontWeight.w600
                            ), textAlign: TextAlign.justify,),
                          )
                        ],
                      ),

                      CadastroFormField(
                        //initialValue: "${pedido.pet.toString()}",
                        controller: _nomePetController,
                        onSaved: (){},
                        label: "Pet",
                        helper: "Digite o nome do seu pet ou dê um nome ao animal encontrado",
                        hint: "Ex: Napoleão, Ralph",
                        icon: Icon(Icons.favorite, color: Colors.orange,),
                      ),

                      CadastroFormField(
                        //initialValue: pedido.medicamento,
                        controller: _medicamentoController,
                        onSaved: (){},
                        label: "Medicamento (Não obrigatório)",
                        helper: "Digite o nome do medicamento que você quer doar/receber",
                        hint: "Ex: Alupurinol",
                        icon: Icon(Icons.add_box, color: Colors.orange,),
                      ),

                      SizedBox(height: 30,),

                      Divider(color: Colors.deepOrange, height: 5,),

                      SizedBox(height: 20,),

                      CadastroFormField(
                        //initialValue: pedido.endereco,
                        controller: _localPetController,
                        onSaved: (){},
                        // ignore: missing_return
                        label: "Local de encontro (Não informe sua residência)",
                        helper: "Informe um local de encontro para receber/doar ou encontrar o animal abandonado",
                        hint: "Ex: Shopping tal, Praça tal (Local Público)",
                        icon: Icon(Icons.place, color: Colors.orange,),
                      ),

                      SizedBox(height: 10,),
                      Divider(color: Colors.deepOrange,),
                      SizedBox(height: 10,),
                      Text("Informe pelo menos uma forma de contato", style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ), overflow: TextOverflow.ellipsis,),


                      CadastroFormField(
                        //initialValue: pedido.contato,
                        controller: _contatoPetController,
                        onSaved: (){},
                        label: "Informe seu Instagram",
                        helper: "Informe sua conta (Instagram) para contato.",
                        hint: "Ex: @contaInstagram",
                        icon: Icon(Icons.chat, color: Colors.orange,),
                      ),

                      CadastroFormField(
                        //initialValue: pedido.facebook,
                        controller: _facebookController,
                        onSaved: (){},
                        label: "Informe sua conta do Facebook",
                        helper: "Informe sua conta (Facebook) para contato.",
                        hint: "Ex: conta do Facebook",
                        icon: Icon(Icons.insert_comment, color: Colors.orange,),
                      ),

                      TextFormField(
                        //initialValue: pedido.numero.toString(),
                        decoration: InputDecoration(
                            hintText: "Este número pode ser usado para entrarem em contato com você.",
                            labelText: "Nº para contato (NÃO OBRIGATÓRIO)",
                            helperText: "Se preferir, informe seu número.",
                            contentPadding: const EdgeInsets.all(12),
                            labelStyle: TextStyle(color: Colors.orange),
                            hintStyle: TextStyle(color: Colors.orange[400]),
                            helperStyle: TextStyle(color: Colors.orangeAccent),
                            icon: Icon(Icons.call, color: Colors.orange,)
                        ),
                        cursorColor: Colors.orange,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        controller: _numeroPetController,
                      ),

                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: CircularButton(
                              backgroundColor: Colors.deepOrange,
                              title: "Editar",
                              colorText: Colors.white,
                              //ignore: missing_return
                              onPressed: () async {

                                String obj, sex;
                                if(objetivo == 0){
                                  obj = "Doar Medicamento";
                                } else if (objetivo==1){
                                  obj = "Receber Medicamento";
                                } else if (objetivo == 2){
                                  obj = "Indicar Abandono";
                                }

                                if(sexo == 0){
                                  sex="Fêmea";
                                } else if(sexo == 1){
                                  sex = "Macho";
                                }

                                if(_formKey.currentState.validate()){
                                  Map<String, dynamic> pedidoData = {
                                    "concluído": pedido.concluido,
                                    "instagram": _contatoPetController.text.isEmpty? pedido.contato : _contatoPetController.text.toString(),
                                    "facebook": _facebookController.text.isEmpty? pedido.facebook :_facebookController.text.toString(),
                                    "endereco":_localPetController.text.isEmpty ? pedido.endereco : _localPetController.text,
                                    "medicamento" : _medicamentoController.text.isEmpty ? pedido.medicamento :_medicamentoController.text.toString(),
                                    "nomepet": _nomePetController.text.isEmpty ? pedido.pet : _nomePetController.text.toString(),
                                    "numero" : _numeroPetController.text.isEmpty ? pedido.numero : _numeroPetController.text.toString(),
                                    "objetivo" : pedido.objetivo,
                                    "sexopet": pedido.sexoPet,
                                    "usuario" : pedido.anjo,
                                    "usuario_do_chamado": uid,
                                  };
                                  print("pedido.id: "+pedido.id);
                                  print("pedido.idChamado: "+pedido.idMeuChamado);
                                  await PedidosModel.of(context).editarPedido(pedidosData: pedidoData, userId: model.firebaseUser.uid, idPedido: pedido.idMeuChamado).then((_){
                                    return Alert(
                                        context: context,
                                        title: "Pedido Editado!",
                                        type: AlertType.success,
                                        desc: "Seu pedido foi editado com sucesso.",
                                        buttons: [
                                          DialogButton(
                                              color: Colors.orange,
                                              child: Text("Fechar", style:
                                              TextStyle(color: Colors.white, fontSize: 20,)),
                                              onPressed: () => Navigator.of(context).pop() /*Navigator.of(context).push(MaterialPageRoute(
                                                           builder: (context) => LoggedScreen()
                                                         )),*/
                                          )
                                        ]
                                    ).show();
                                  }).catchError((e){
                                    return Alert(
                                        context: context,
                                        title: "Erro!",
                                        type: AlertType.error,
                                        desc: "Infelizmente não conseguimos editar o seu pedido."
                                            "Erro: ${e.toString()}",
                                        buttons: [
                                          DialogButton(
                                              color: Colors.orange,
                                              child: Text("Fechar", style:
                                              TextStyle(color: Colors.white, fontSize: 20,)),
                                              onPressed: () => Navigator.of(context).pop() /*Navigator.of(context).push(MaterialPageRoute(
                                                           builder: (context) => LoggedScreen()
                                                         )),*/
                                          )
                                        ]
                                    ).show();
                                  });

                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              );
            }
        ),
      ),
    );
  }
}
