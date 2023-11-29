import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delice_bko/Composants/navbar.dart';
import 'package:delice_bko/Pages/accueil.dart';
import 'package:delice_bko/Pages/inscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PageConnexion extends StatefulWidget {
  const PageConnexion({Key? key}) : super(key: key);

  @override
  State<PageConnexion> createState() => _PageConnexionState();
}

class _PageConnexionState extends State<PageConnexion> {
  TextEditingController emailController = TextEditingController();
  TextEditingController motpasseController = TextEditingController();
  bool obscureText = true;
  bool emailVide = false;
  bool emailInvalide = false;
  bool motpasseVide = false;
  bool erreurMotDePasse = false;

  void _toggleObscured() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  bool isEmailValid(String email) {
    final RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return regex.hasMatch(email);
  }

  Future<void> connectUser() async {
    setState(() {
      emailVide = emailController.text.isEmpty;
      motpasseVide = motpasseController.text.isEmpty;
      emailInvalide = !isEmailValid(emailController.text);
    });

    if (!emailVide && !motpasseVide && !emailInvalide) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: motpasseController.text,
        );
        print('Connexion réussie');
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()),
        );
        
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            print('Aucun utilisateur trouvé avec cette adresse e-mail.');
          } else if (e.code == 'wrong-password') {
            print('Mauvais mot de passe fourni pour cet utilisateur.');
          }
        } else {
          print('Erreur inattendue : $e');
        }
      }
    }

    getUserPassword(emailController.text).then((String? motDePasseFirestore) {
      if (motDePasseFirestore != null &&
          motDePasseFirestore == motpasseController.text) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PageAccueil()),
        );
      } else {
        setState(() {
          erreurMotDePasse = true;
        });
      }
    });
  }

  Future<String?> getUserPassword(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('utilisateur')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.get('password');
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération du mot de passe : $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
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
            child: SizedBox(
              height: 635,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Image.asset('assets/images/logo.png'),
                  ),

                  const Padding(padding: EdgeInsets.only(top: 35.0)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        labelText: 'Adresse mail',
                        hintText: 'exemple@gmail.com',
                        errorText: emailVide
                            ? 'Veuillez entrer une adresse e-mail'
                            : (emailInvalide
                                ? 'Adresse e-mail invalide'
                                : null),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                    child: TextField(
                      controller: motpasseController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        labelText: 'Mot de passe',
                        hintText: 'Entrez votre mot de passe',
                        suffixIcon: IconButton(
                          icon: Icon(obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _toggleObscured,
                        ),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      // Action à exécuter lorsqu'on clique sur "Mot de passe oublié"
                    },
                    child: const Text(
                      'Mot de passe oublié',
                      style: TextStyle(
                        color: Color.fromARGB(255, 159, 33, 243),
                        fontSize: 15,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: connectUser,
                    child: const Text(
                      'Connexion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      // Redirection vers la page d'inscription
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageInscription(),
                        ),
                      );
                    },
                    child: const Text(
                      'Je crée mon compte maintenant',
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
                        // Redirection vers la page inscription
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
