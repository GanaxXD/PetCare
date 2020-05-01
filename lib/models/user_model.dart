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
    Função sobreescrita para carregar o usuário logado
    assim que o app for aberto, se houver usuário logado.
    @param: listner;
    @result: nenhum.
  */
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

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
      firebaseUser = user; // só funciona com o firebase_auth: ^0.11.1+12
      onSuccess();

      /*
      Função para salvar todos os dados do usuário no
      banco.
       */
      await _saveUserData(userData);

      isLoading = false;
      notifyListeners();
    }).catchError((e){
      print(e.toString());
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
  void signIn({@required String email,
    @required String pass,
    @required VoidCallback onSuccess,
    @required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();
    
    _auth.signInWithEmailAndPassword(
        email: email,
        password: pass).then((user) async {
      firebaseUser = user;
      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e){
      print(e.toString());
      onFail();
      isLoading=false;
      notifyListeners();
    });
  }

  /*
  Função para recuperar a senha do usuário.
  @param: nenhum
  @result: nenhum
   */
  void recoverPass(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

  /*
  Função que verifica se um usuário está logado ou não.
  @param: nenhum
  @result: true para logado, false para não logado
   */
  bool isLoggedIn(){
    return firebaseUser != null;
  }

  /*
  Função que realiza o loggout de um usuário.
  @param: nenhum
  @result: nenhum.
   */
  void signOut() async{
    await _auth.signOut();
    firebaseUser = null;
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

  /*
  Função para carregar os dados do usuário do banco de dados.
  @param: null.
  @result: future do tipo null.
  */
  Future<Null> _loadCurrentUser() async{
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if(firebaseUser != null){
      if(userData["usuario"] == null){
        DocumentSnapshot docUser =
            await Firestore.instance.collection("usuarios").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }
}