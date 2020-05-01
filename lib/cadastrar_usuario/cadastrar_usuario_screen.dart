import 'package:flutter/material.dart';
import 'package:petcare_app/logged_pages/logged_screen.dart';
import 'package:petcare_app/login/widgets/form_field.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:petcare_app/widgets/circular_button.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastrarUsuario extends StatefulWidget {
  @override
  _CadastrarUsuarioState createState() => _CadastrarUsuarioState();
}

class _CadastrarUsuarioState extends State<CadastrarUsuario> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _contatoController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastre-se", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading == true)
            return Center(child: CircularProgressIndicator(),);
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FormFields(
                      // ignore: missing_return
                      validate: (name){
                        if(name.toString().isEmpty)
                          return "Nome obrigatório";
                      },
                      obscure: false,
                      controller: _nameController,
                      label: "Nome",
                      helper: "Informe seu nome.",
                      hint: "Informe um nome para o cadastro.",
                      //onSaved: (){},
                    ),

                    FormFields(
                      // ignore: missing_return
                      validate: (email){
                        if(email.toString().isEmpty || !email.toString().contains("@"))
                          return "Informe um e-mail válido.";
                      },
                      obscure: false,
                      controller: _emailController,
                      label: "E-Mail",
                      helper: "Informe seu e-mail para realizar o login.",
                      hint: "Informe um e-mail válido.",
                      //onSaved: (){},
                    ),

                    FormFields(
                      // ignore: missing_return
                      validate: (contato){
                        if(contato.toString().isEmpty)
                          return "Um contato é obrigatório (Instagram, Facebook).";
                      },
                      obscure: false,
                      controller: _contatoController,
                      label: "Contato (Instagram, Facebook, etc)",
                      helper: "Informe seu contato para que outros falem com você.",
                      hint: "Informe um contato válido.",
                      //onSaved: (){},
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Este número pode ser usado para entrarem em contato com você.",
                          labelText: "Nº para contato (NÃO OBRIGATÓRIO)",
                          helperText: "Se preferir, informe seu número.",
                          contentPadding: const EdgeInsets.all(12),
                          labelStyle: TextStyle(color: Colors.orange),
                          hintStyle: TextStyle(color: Colors.orange[400]),
                          helperStyle: TextStyle(color: Colors.orangeAccent)
                      ),
                      cursorColor: Colors.orange,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      controller: _numberController,
                      validator: (number){
                        if(number.toString().length > 0 && number.toString().length < 11){
                          return "Digite um número com 11 dígitos. CAMPO NÃO OBRIGATÓRIO";
                        } else {
                          return null;
                        }
                      },
                    ),

                    FormFields(
                      // ignore: missing_return
                      validate: (senha){
                        if(senha.toString().isEmpty || senha.toString().length <8)
                          return "Digite uma senha de pelo menos 8 caracteres.";
                      },
                      obscure: true,
                      controller: _senhaController,
                      label: "Senha",
                      helper: "Crie uma senha.",
                      hint: "Esta senha será usada para entrar no aplicativo.",
                      //onSaved: (){},
                    ),

                    SizedBox(height: 20,),
                    Divider(color: Colors.deepOrange,),
                    SizedBox(height: 20,),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                        child: CircularButton(
                          backgroundColor: Colors.orangeAccent,
                          title: "Cadastrar",
                          colorText: Colors.white,
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              Map<String,dynamic> userData = {
                                "usuario":_nameController.text,
                                "contato": _contatoController.text,
                                "numero": _numberController.text,
                                "email": _emailController.text,
                              };

                              print(userData);

                              model.signUp(
                                  userData: userData,
                                  pass: _senhaController.text,
                                  onSuccess: _onSuccess,
                                  onFail: _onFail,
                              );
                            }
                          },
                        ),
                    ),
                  ],
                ),
            ),
          );
        },
      ),
    );
  }

  /*
  Função para caso ocorra sucesso ao cadastrar o usuário
  @param: nenhum
  @result: nenhum
   */
  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
          content: Text("Usuário criado com sucesso!", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600
          ),),
      ),
    );

    Future.delayed(Duration(seconds: 3)).then((_){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoggedScreen()
      ));
    });
  }

/*
  Função para caso ocorra falha ao cadastrar o usuário
  @param: nenhum
  @result: nenhum
   */
  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 10),
        backgroundColor: Colors.red,
        content: Text("Falha a criar o usuário."
            "Verifique se o e-mail já não foi cadastrado. "
            "Somente uma conta pode ser gerada "
            "para cada e-mail.", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600
        ),),
      ),
    );
  }
}
