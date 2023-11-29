


import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{

  FirebaseAuth _auth =FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential credential= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch (e){
      print('Une erreur a été rencontrée!!!');
    }
    return null;
  }
}


