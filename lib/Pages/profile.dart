import 'package:flutter/material.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({Key? key}) : super(key: key);

  @override
  _PageProfileState createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }
    // Fonction de déconnexion
  void _logout() {
    // Ajoutez ici le code pour gérer la déconnexion, par exemple, utilisez FirebaseAuth
    // FirebaseAuth.instance.signOut();
    // Naviguez ensuite vers l'écran de connexion ou la page d'accueil, selon vos besoins
    Navigator.pop(context); // Fermez la page de profil
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.10, 1.2585],
              colors: [
                Color.fromARGB(176, 255, 128, 0),

                Colors.white,
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      // Ajoutez ici la logique pour revenir en arrière
                    },
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 145,
                  right: 145,

                  child: SizedBox(
                    height:  100,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                Positioned(
                  top: 125,
                  left: 145,
                  right: 145,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profil.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 20,
                  height: 450,
                  right: 20,
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
      // ==================NOM UTILISATEUR   ===================== 
                          const Padding(
                            padding: EdgeInsets.only(top:8.0,bottom: 8.0),
                            child: Center(
                              child: Text('Nom D\'tilisateur',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              ),                            
                            ),
                          ),

                          const Center(
                            child: Text('Nom complet',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                            ),                            
                          ),
 // ==================ADRESSE MAIL DE L'UTILISATEUR ===================== 
                          const Padding(
                            padding: EdgeInsets.only(top:8.0,bottom: 8.0),
                            child: Center(
                              child: Text('Adresse mail',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              ),                            
                            ),
                          ),

                          const Center(
                            child: Text('exempl@gmail.com',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                            ),                            
                          ),

     // ==================ADRESSE UTILISATEUR ===================== 
                          const Padding(
                            padding: EdgeInsets.only(top:8.0,bottom: 8.0),
                            child: Center(
                              child: Text('Adresse utilisateur',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              ),                            
                            ),
                          ),

                          const Center(
                            child: Text('lafiabougou; Rue:213; Porte: 260',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                            ),                            
                          ),
  // ==================NUMERO ===================== 
                          const Padding(
                            padding: EdgeInsets.only(top:8.0,bottom: 8.0),
                            child: Center(
                              child: Text('Téléphone: ',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              ),                            
                            ),
                          ),

                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom:50),
                              child: Text('+223 72664229',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                              ),
                            ),                            
                          ),

                           Positioned(
                                top: 300,
                                left: 50,
                                right: 50,
                                bottom: 0,
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: _logout,
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // Couleur de fond du bouton
                                      onPrimary: Colors.white, // Couleur du texte du bouton
                                    ),
                                    child: const Text('Déconnexion'),
                                  ),
                                ),
                              )
                   
                          
                          // Ajoutez d'autres informations du profil ici
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
