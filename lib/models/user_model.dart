import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  /*
  Função para cadastrar um novo usuário.
  @param: Mapa com os dados do usuário, a senha e
          funções de sucesso ou falha
  @result: nenhum
   */
  void signUp({
    @required Map<String, dynamic> userData,
    @required String pass,
    @required VoidCallback onSuccess,
    @required VoidCallback onFail
  }){
    isLoading = true;
    notifyListeners();

    /*
    A função createUser retorna um future, logo, é necessário
    usar o then para validar o usuário que será retornado.
    Se o usuário já tiver cadastrado o email, ou o email não for válido
    será necessário tratar o erro que será exibido.
     */
    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((user) async {
      firebaseUser = user; //só funciona com o firebase_auth: ^0.11.1+12
      print(firebaseUser.uid);
      onSuccess();

      /*
      Função para salvar todos os dados do usuário no
      banco.
       */
      await _saveUserData(userData);
      print("Cheguei aqui");
      isLoading = false;
      print(isLoading);
      notifyListeners();

    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  /*
  Função para o usuário logar.
  @param: nenhum
  @result: nenhum
   */
  void signIn(){
    isLoading = true;
    notifyListeners();
  }

  /*
  Função para recuperar a senha do usuário.
  @param: nenhum
  @result: nenhum
   */
  void recoverPass(){

  }

  /*
  Função  que retorna se o usuário está logado.
  @param: nenhum
  @result: true para logado, false para não logado
   */
  bool isLoggedIn(){
    return firebaseUser != null;
  }

  /*
  Função  para realizar o logout.
  @param: nenhum
  @result: nenhum
   */
  void signOut(){
    _auth.signOut();
    firebaseUser= null;
    userData = Map();
    notifyListeners();
  }

  /*
  Função para salvar um novo usuário no banco de dados.
  @param: Mapa contendo os dados do usuário.
  @result: future do tipo null.
   */
  Future<Null> _saveUserData (Map<String, dynamic> userData) async{
    this.userData = userData;
    await Firestore.instance.collection("usuarios").document(firebaseUser.uid).setData(userData);
  }
}