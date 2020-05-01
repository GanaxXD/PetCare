import 'package:flutter/material.dart';
import 'package:petcare_app/cadastrar_usuario/cadastrar_usuario_screen.dart';
import 'package:petcare_app/logged_pages/logged_screen.dart';
import 'package:petcare_app/login/widgets/form_field.dart';
import 'package:petcare_app/models/user_model.dart';
import 'package:petcare_app/widgets/circular_button.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        return WillPopScope(
          onWillPop: (){
            Navigator.of(context).pop();
          },
          child: Scaffold(
            key: _ScaffoldKey,
            appBar: AppBar(
              title: Text("Entrar no sistema"),
              centerTitle: true,
              backgroundColor: Colors.orange,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FormFields(
                        obscure: false,
                        label: "E-mail",
                        hint: "Digite seu e-mail",
                        helper: "Utilize seu e-mail para realizar o login.",
                        controller: _email,
                        validate: (email){
                          if(email.toString().isEmpty || !email.toString().contains("@"))
                            return "E-Mail necessário para realizar o login.";
                        },
                      ),

                      FormFields(
                        obscure: true,
                        label: "Senha",
                        hint: "Digite sua senha",
                        helper: "Digite sua senha para realizar o login.",
                        controller: _senha,
                        validate: (senha){
                          if(senha.toString().isEmpty)
                            return "Informe sua senha.";
                        },
                      ),

                      SizedBox(height: 10,),

                      CircularButton(
                        backgroundColor: Colors.orange,
                        title: "Logar",
                        colorText: Colors.white,
                        onPressed: (){
                          //Por aqui o código de validação do Firebase
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => LoggedScreen()
                          ));

                          /*if(_key.currentState.validate()){
                            model.signIn(
                              email: _email.text,
                              pass: _senha.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail,
                            );
                          }*/

                        },
                      ),

                      Divider(color: Colors.deepOrange,),

                      GestureDetector(
                        onTap: (){
                          if(_email.text.isEmpty){
                            _ScaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 10),
                                  backgroundColor: Colors.red,
                                  content: Text("Digite um email cadastrado"
                                      "para que você recupere sua senha.", style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                  ),),
                                ),
                            );
                          } else {
                            model.recoverPass(_email.text);
                            _ScaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.green,
                                content: Text("Visite o e-mail informado"
                                    " para recuperar sua senha.", style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600
                                ),),
                              ),
                            );
                          }
                        },
                        child: Text("Esqueceu sua senha? Clique aqui.", style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            decoration: TextDecoration.underline
                        ),
                        ),
                      ),

                      SizedBox(height: 30,),
                      Divider(color: Colors.deepOrange,),

                      Center(
                        child: Text("Não possui uma conta?", style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                        ),
                      ),

                      SizedBox(height: 20,),

                      CircularButton(
                        backgroundColor: Colors.black26,
                        colorText: Colors.white,
                        title: "Cadastre-se",
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CadastrarUsuario()
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /*
  Função para caso ocorra sucesso ao logar.
  @param: nenhum
  @result: nenhum
   */
  void _onSuccess(){
    _ScaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        content: Text("Bem-vindo de volta!", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600
        ),),
      ),
    );

    Future.delayed(Duration(seconds: 3)).then((_){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoggedScreen()));
    });
  }

/*
  Função para caso ocorra falha ao logar.
  @param: nenhum
  @result: nenhum
   */
  void _onFail(){
    _ScaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text("Credenciais incorretas. Verifique"
            " se seus dados foram digitados corretamente.", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600
        ),),
      ),
    );
  }
}
