import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare_app/logged_pages/logged_screen.dart';
import 'package:petcare_app/logged_pages/widgets/cadastro_form_field.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:petcare_app/pedidos/pedidos.dart';
import 'package:petcare_app/pedidos/pedidos_model.dart';
import 'package:petcare_app/widgets/circular_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';

class Cadastrar extends StatefulWidget {
  @override
  _CadastrarState createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {

  int sexo =1, objetivo =1;
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
    return Scaffold(
      key: _scaffoldKey,
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

                    CadastroFormField(
                      controller: _nomePetController,
                      onSaved: (){},
                      validate: (nome){
                        if(nome.toString().length<3){
                          return "O nome do pet é obrigatório. Digite um nome com mais de 3 caracteres";
                        }
                      },
                      label: "Pet",
                      helper: "Digite o nome do seu pet ou dê um nome ao animal encontrado",
                      hint: "Ex: Napoleão, Ralph",
                      icon: Icon(Icons.favorite, color: Colors.orange,),
                    ),

                    CadastroFormField(
                      controller: _medicamentoController,
                      onSaved: (){},
                      validate: (medicamento){
                        if(medicamento.toString().length >1 && medicamento.toString().length <2)
                          return "Preencha com um medicamento de nome válido.";
                      },
                      label: "Medicamento (Não obrigatório)",
                      helper: "Digite o nome do medicamento que você quer doar/receber",
                      hint: "Ex: Alupurinol",
                      icon: Icon(Icons.add_box, color: Colors.orange,),
                    ),

                    SizedBox(height: 30,),

                    Text("OBJETIVO DO CADASTRO", style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Doar Medicamentos", style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ), overflow: TextOverflow.ellipsis,),
                        Radio(
                          onChanged: (int v){
                            setState(() {
                              objetivo = v;
                            });
                          },
                          groupValue: objetivo,
                          value: doar,
                        ),

                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Pedir Medicamentos", style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ), overflow: TextOverflow.ellipsis,),
                        Radio(
                          onChanged: (int v){
                            setState(() {
                              objetivo = v;
                            });
                          },
                          groupValue: objetivo,
                          value: receber,
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Indicar Abandono", style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ), overflow: TextOverflow.ellipsis,),
                        Radio(
                          onChanged: (int v){
                            setState(() {
                              objetivo = v;
                            });
                          },
                          groupValue: objetivo,
                          value: abandonado,
                        ),

                      ],
                    ),

                    SizedBox(height: 20,),

                    Divider(color: Colors.deepOrange, height: 5,),

                    SizedBox(height: 20,),

                    Text("Informe o sexo do animal", style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ), overflow: TextOverflow.ellipsis,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Macho", style: TextStyle(color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),),
                        Radio(
                            value: macho,
                            groupValue: sexo,
                            onChanged: (int v){
                              setState(() {
                                sexo = v;
                              });
                            }
                        ),
                        Padding(padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Fêmea", style: TextStyle(color: Colors.orange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              ),),
                              Radio(
                                  value: femea,
                                  groupValue: sexo,
                                  onChanged: (int v){
                                    setState(() {
                                      sexo = v;
                                    });
                                  }
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),

                    Divider(color: Colors.deepOrange, height: 5,),

                    SizedBox(height: 20,),

                    CadastroFormField(
                      controller: _localPetController,
                      onSaved: (){},
                      // ignore: missing_return
                      validate: (local){
                        if(local.toString().isEmpty) {return "Um local de encontro é obrigatório.";}
                      },
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
                      controller: _contatoPetController,
                      onSaved: (){},
                      // ignore: missing_return
                      /*validate: (contato){
                        if(contato.toString().isEmpty || contato.toString().length < 3) return "Um contato é obrigatório (Instagram, Facebook, etc).";
                      },*/
                      label: "Informe seu Instagram",
                      helper: "Informe sua conta (Instagram) para contato.",
                      hint: "Ex: @contaInstagram",
                      icon: Icon(Icons.chat, color: Colors.orange,),
                    ),

                    CadastroFormField(
                      controller: _facebookController,
                      onSaved: (){},
                      // ignore: missing_return
                      /*validate: (contato){
                        if(contato.toString().isEmpty || contato.toString().length < 3) return "Um contato é obrigatório (Instagram, Facebook, etc).";
                      },*/
                      label: "Informe sua conta do Facebook",
                      helper: "Informe sua conta (Facebook) para contato.",
                      hint: "Ex: conta do Facebook",
                      icon: Icon(Icons.insert_comment, color: Colors.orange,),
                    ),

                    TextFormField(
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
                      validator: (number){
                        if(number.toString().length > 0 && number.toString().length < 11){
                          return "Digite um número com 11 dígitos. CAMPO NÃO OBRIGATÓRIO";
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: CircularButton(
                            backgroundColor: Colors.deepOrange,
                            title: "Cadastrar",
                            colorText: Colors.white,
                            //ignore: missing_return
                            onPressed: () async {
                              if(_nomePetController.text.length<3 || _localPetController.text.length == null || _localPetController.text.length < 10 || _localPetController.text.isEmpty || (_medicamentoController.text.length >0 && _medicamentoController.text.length<3)){
                                return Alert(
                                    context: context,
                                    title: "Dados incorretos.",
                                    type: AlertType.error,
                                    desc: "Verifique se você informou um Local de Encontro com pelo menos 10 caracteres (Não informe o endereço de sua casa)."
                                        " Verifique também se o nome do pet cadastrado possui mais de 3 caracteres. "
                                        "Verifique ainda se ao digitar um medicamento (que não é obrigatório), você "
                                        "digitou o nome de um medicamento com mais de 3 caracteres.",
                                    buttons: [
                                      DialogButton(
                                        child: Text("Ok", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                        ),),
                                        onPressed: ()=> Navigator.of(context).pop(),
                                        color: Colors.orange,
                                      ),
                                    ]
                                ).show();
                              }
                              if(_facebookController.text.isEmpty && _contatoPetController.text.isEmpty && _numeroPetController.text.isEmpty){
                                return Alert(
                                    context: context,
                                    title: "Contato inválido",
                                    type: AlertType.error,
                                    desc: "Você precisa informar pelo menos uma das três "
                                        "formas de contato, para que as pessoas possam entrar "
                                        "em contato com você.",
                                    buttons: [
                                      DialogButton(
                                          child: Text("Ok", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                          ),),
                                          onPressed: ()=> Navigator.of(context).pop(),
                                          color: Colors.orange,
                                      ),
                                    ]
                                ).show();
                              }

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

                              var dataPedido = Timestamp.fromDate(DateTime.now());
                              /*
                              Chave para a edição do pedido
                               */
                              var inicio = dataPedido.microsecondsSinceEpoch;
                              print("Inicio: "+inicio.toString());


                              if(_formKey.currentState.validate()){
                                Map<String, dynamic> pedidoData = {
                                  "concluído": "N",
                                  "instagram": _contatoPetController.text.isEmpty? "Sem Instagram" : _contatoPetController.text.toString(),
                                  "facebook": _facebookController.text.isEmpty? "Sem Facebook":_facebookController.text.toString(),
                                  "data_do_pedido": dataPedido,
                                  "endereco":_localPetController.text.toString(),
                                  "medicamento" : _medicamentoController.text.isEmpty ? "Não necessita de medicamento" :_medicamentoController.text.toString(),
                                  "nomepet": _nomePetController.text.toString(),
                                  "numero" : _numeroPetController.text.isEmpty ? "Sem número" : _numeroPetController.text.toString(),
                                  "objetivo" : obj,
                                  "sexopet": sex,
                                  "usuario" : !model.isLoggedIn() ? "Usuário desconhecido" : model.userData["usuario"].toString(),
                                  "usuario_do_chamado": !model.isLoggedIn() ? "Sem Id" : model.firebaseUser.uid,
                                  "chave":inicio.toString(),
                                };


                                Pedidos pedido = Pedidos();
                                pedido.concluido = "N";
                                pedido.facebook = _facebookController.text.isEmpty? "Sem Facebook":_facebookController.text.toString();
                                pedido.contato = _contatoPetController.text.isEmpty? "Sem Instagram" : _contatoPetController.text.toString();
                                pedido.dataDoPedido = pedidoData["data_do_pedido"];
                                pedido.endereco =  _localPetController.text.toString();
                                pedido.medicamento = _medicamentoController.text.isEmpty ? "Não necessita de medicamento" :_medicamentoController.text.toString();
                                pedido.pet = _nomePetController.text.toString();
                                pedido.numero = _numeroPetController.text.isEmpty ? "Sem número" : _numeroPetController.text.toString();
                                pedido.sexoPet = sex;
                                pedido.objetivo = obj;
                                pedido.chave = inicio.toString();
                                pedido.anjo = !model.isLoggedIn() ? "Usuário desconhecido" : model.userData["usuario"].toString();
                                pedido.id = pedidoData["usuario"]+pedidoData["chave"];
                                pedido.idMeuChamado = null; //pegará na função addPedido, logo abaixo.

                                await PedidosModel.of(context).addPedido(pedidosData: pedidoData);
                                print(pedido.id);
                                await PedidosModel.of(context).addPedidoPessoal(pedido, model.firebaseUser.uid);
                                Alert(
                                    context: context,
                                    title: "Pedido Cadastrado!",
                                    type: AlertType.success,
                                    desc: "Seu pedido será exibido na tela principal.",
                                  buttons: [
                                    DialogButton(
                                        color: Colors.orange,
                                        child: Text("Fechar", style:
                                        TextStyle(color: Colors.white, fontSize: 20,)),
                                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => LoggedScreen()
                                        ))

                                    )
                                  ]
                                ).show();
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
