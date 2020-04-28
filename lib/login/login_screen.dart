import 'package:flutter/material.dart';
import 'package:petcare_app/logged_pages/logged_screen.dart';
import 'package:petcare_app/login/widgets/form_field.dart';
import 'package:petcare_app/widgets/circular_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop();
      },
      child: Scaffold(
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
                    ),

                    FormFields(
                      obscure: true,
                      label: "Senha",
                      hint: "Digite sua senha",
                      helper: "Digite sua senha para realizar o login.",
                      controller: _senha,
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
                      },
                    ),

                    Divider(color: Colors.deepOrange,),

                    Text("Esqueceu sua senha?", style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline
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
                      onPressed: (){},
                    ),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}
