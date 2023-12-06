import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delice_bko/Pages/accueil.dart';
import 'package:delice_bko/Pages/connexion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PageInscription extends StatefulWidget {
  const PageInscription({Key? key}) : super(key: key);

  @override
  State<PageInscription> createState() => _PageInscriptionState();
}

class _PageInscriptionState extends State<PageInscription> {
  String? errorName = null;
  String? errorEmail = null;
  String? errorPassword = null;
  String? errorConfirm = null;

  bool _obscuredText = true;
  TextEditingController input_nom = TextEditingController();
  TextEditingController input_email = TextEditingController();
  TextEditingController input_motpasse = TextEditingController();
  TextEditingController input_confirm_motpasse = TextEditingController();

  void _toogleObscured() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  bool verified_motpasse() {
    if (input_confirm_motpasse.text == input_motpasse.text) {
      return true;
    }
    return false;
  }

  bool isEmailValid(String email) {
    final RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return regex.hasMatch(email);
  }

  void createUser() async {
    bool passe = verified_motpasse();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: input_email.text,
        password: input_motpasse.text,
      );
      if (credential.user != null) {
        final uid = credential.user!.uid;
        FirebaseFirestore.instance.collection('utilisateur').doc(uid).set({
          'nom': input_nom.text,
          'email': input_email.text,
          'mot de passe': input_motpasse.text,
        });
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        // builder: (context) => HomePage(),
        //));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  String? NameValidate(String value) {
    if (value.isEmpty) {
      return 'Veuillez remplir le champ vide';
    }
    return null;
  }

  String? EmailValidate(String value) {
    if (value.isEmpty) {
      return 'Veuillez remplir le champ vide';
    } else if (!isEmailValid(value)) {
      return 'Veuillez saisir une adresse email valide.';
    }
    return null;
  }

  String? PasswordValidate(String value) {
    if (value.isEmpty) {
      return 'Veuillez remplir le champ vide';
    }
    return null;
  }

  String? ConfirmValidate(String value) {
    if (value.isEmpty) {
      return 'Veuillez remplir le champ vide';
    } else if (value != input_motpasse.text) {
      return 'Les mots de passe ne correspondent pas.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          // ============Adopter le container à la taille de l'ecran============
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: [0.6178, 1.2585],
              colors: [
                Colors.white,
                Color(0xFFFF8000),
              ],
            ),
          ),
          child: Center(
            // Contenu de votre page
            child: SizedBox(
              height: 700,
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                    child: Image.asset('assets/images/logo.png'),
                  ),

                  //===================Champ Nom complet===============================

                  const Padding(padding: EdgeInsets.only(top: 20.0)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                    child: TextField(
                      controller: input_nom,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        labelText: 'Votre nom complet',
                        hintText: 'Nom et prenom',
                        errorText: errorName,
                      ),
                    ),
                  ),

                  //===================Champ Adresse mail===============================

                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                    child: TextField(
                      controller: input_email,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        labelText: 'Adresse mail',
                        hintText: 'Entrez votre mail',
                        errorText: errorEmail,
                      ),
                    ),
                  ),

                  //===================Mot de passe===============================
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                    child: TextField(
                      controller: input_motpasse,
                      obscureText: _obscuredText,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        labelText: 'Mot de passe',
                        hintText: 'Entrez votre mot de passe',
                        suffixIcon: IconButton(
                          icon: Icon(_obscuredText ? Icons.visibility : Icons.visibility_off),
                          onPressed: _toogleObscured,
                        ),
                        errorText: errorPassword,
                      ),
                    ),
                  ),

                  //===================Mot de passe confirmation===============================
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 10),
                    child: TextField(
                      controller: input_confirm_motpasse,
                      obscureText: _obscuredText,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        labelText: 'Confirmation',
                        hintText: 'Confirmez votre mot de passe',
                         suffixIcon: IconButton(
                          icon: Icon(_obscuredText ? Icons.visibility : Icons.visibility_off),
                          onPressed: _toogleObscured,
                        ),
                        errorText: errorConfirm,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8000),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      setState(() {
                        errorName = NameValidate(input_nom.text);
                        errorEmail = EmailValidate(input_email.text);
                        errorPassword = PasswordValidate(input_motpasse.text);
                        errorConfirm = ConfirmValidate(input_confirm_motpasse.text);
                      });

                      if (errorName == null &&
                          errorEmail == null &&
                          errorPassword == null &&
                          errorConfirm == null) {
                        // All fields are valid, proceed with registration
                        createUser();
                         Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PageConnexion()),
                            );
                      }
                    },
                    child: const Text(
                      'S\'inscrire',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),

                  //===================Dèjà inscrit===============================

                  TextButton(
                    onPressed: () {
                      // Redirection vers la page connexion
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PageConnexion()),
                      );
                    },
                    child: const Text(
                      'J\'ai déjà un compte',
                      style: TextStyle(
                        color: Color.fromARGB(255, 159, 33, 243),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Text('Ou'),
                  SizedBox(
                    width: 175.0,
                    child: TextButton(
                      onPressed: () {
                        // inscription avec google
                      },
                      child: Row(
                        children: [
                          const Text(
                            'Se connecter avec ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 159, 33, 243),
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: Image.asset('assets/images/google.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 130,
                      child: Image.asset('assets/images/food.png'),
                    ),
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
