import 'package:flutter/material.dart';
import 'package:petcare_app/login/widgets/form_field.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:petcare_app/widgets/circular_button.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:petcare_app/logged_pages/principal_screen.dart';
import 'package:petcare_app/logged_pages/logged_screen.dart';

class TelaCadastrar extends StatefulWidget {
  @override
  _TelaCadastrarState createState() => _TelaCadastrarState();
}

class _TelaCadastrarState extends State<TelaCadastrar> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastre-se"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      key: _scaffoldKey,
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){

          if(model.isLoading==true)
            return Center(child: CircularProgressIndicator(),);

          return SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FormFields(
                      hint: "Nome",
                      helper: "Digite seu nome",
                      label: "Informe seu nome para realizar o cadastro",
                      controller: nomeController,
                      obscure: false,
                      validate: (text){
                        if(text.toString().isEmpty) return "Nome inválido";
                      },
                    ),

                    FormFields(
                      hint: "E-Mail",
                      helper: "Digite um e-mail válido",
                      label: "Informe seu e-mail de cadastro",
                      controller: emailController,
                      obscure: false,
                      validate: (text){
                        if(!text.toString().contains("@")) return "E-Mail inválido";
                      },
                    ),
                    FormFields(
                      hint: "Senha",
                      helper: "Digite uma senha com no mínimo 8 caracteres",
                      label: "Crie uma senha",
                      controller: senhaController,
                      obscure: true,
                      validate: (text){
                        if(text.toString().length < 8) return "Digite uma senha de no mínimo 8 caracteres";
                      },
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: CircularButton(
                              backgroundColor: Colors.orange,
                              title: "Cadastrar",
                              colorText: Colors.white,
                              onPressed: (){
                                if(_formKey.currentState.validate()){

                                  Map<String, dynamic> userData = {
                                    "usuario": nomeController.text,
                                    "email": emailController.text
                                  };

                                  model.signUp(
                                        userData: userData,
                                        pass: senhaController.text,
                                        onSuccess: _onSuccess,
                                        onFail: _onFail
                                    );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          );
        }
      ),
    );
  }

  /*
  Função para exibir uma mensagem de sucesso, caso ocorra,
  na criação do usuário.
  @param:
  @result:
   */
  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso!", style: TextStyle(
        color: Colors.white,
      ),),
        backgroundColor: Colors.orangeAccent,
        duration: Duration(seconds: 3),
      )
    );
    Future.delayed(Duration(
      seconds: 3,
    )).then((_){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoggedScreen()
      ));
    });

  }

  /*
  Função para exibir uma mensagem de erro, caso ocorra,
  na criação do usuário.
  @param:
  @result:
   */
  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar o usuário. Verifique se todos"
            "os campos foram preenchidos corretamente"
            "ou se o e-mail usado já não foi cadastrado antes por você!", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 7),
        )
    );
  }

}
