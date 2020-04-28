import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare_app/logged_pages/principal_screen.dart';
import 'package:petcare_app/logged_pages/widgets/cadastro_form_field.dart';
import 'package:petcare_app/widgets/circular_button.dart';

class Cadastrar extends StatefulWidget {
  @override
  _CadastrarState createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {

  int sexo, objetivo;
  final int macho =1, femea =0;
  final int receber = 1, doar = 0, abandonado = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min, //Para os campos filhos da coluna que sejam flexible e expanded possa aparecer na tela
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CadastroFormField(
                  onSaved: (){},
                  validate: (){},
                  label: "Anjo",
                  helper: "Digite aqui o seu nome",
                  hint: "Ex: Ana Lúcia, João Carlos",
                  icon: Icon(Icons.person, color: Colors.orange,),
                ),

                CadastroFormField(
                  onSaved: (){},
                  validate: (){},
                  label: "Pet",
                  helper: "Digite o nome do seu pet ou dê um nome ao animal encontrado",
                  hint: "Ex: Napoleão, Ralph",
                  icon: Icon(Icons.favorite, color: Colors.orange,),
                ),

                SizedBox(height: 20,),

                Text("Objetivo do cadastro", style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),),

                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
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
                  onSaved: (){},
                  validate: (){},
                  label: "Local de encontro (Não informe sua residência)",
                  helper: "Informe um local de encontro para receber/doar ou encontrar o animal abandonado",
                  hint: "Ex: Shopping tal, Praça tal (Local Público)",
                  icon: Icon(Icons.place, color: Colors.orange,),
                ),

                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: CircularButton(
                        backgroundColor: Colors.deepOrange,
                        title: "Cadastrar",
                        onPressed: (){

                        },
                        colorText: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}
