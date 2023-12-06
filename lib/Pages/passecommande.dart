import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasseCommande extends StatefulWidget {
  final Map<String, dynamic> plat;

  const PasseCommande({Key? key, required this.plat}) : super(key: key);

  @override
  State<PasseCommande> createState() => _PasseCommandeState();
  
}

class _PasseCommandeState extends State<PasseCommande> {

  late Map<String, dynamic> plats;
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  int calculateTotalAmount() {
    // Remplacez cette logique par votre propre logique de calcul du montant total
    return widget.plat['data']['prix'] * quantity;
  }
// =============================================================

   void ajoutCommande() async {
    try {
      // Récupérer l'ID de l'utilisateur et du restaurant (remplacez cela par votre propre logique d'authentification et de récupération d'ID)
      String userId = FirebaseAuth.instance.currentUser!.uid; // Remplacez ceci par l'ID réel de l'utilisateur
      String restaurantId = widget.plat['data']['restaurantId']; // l'id du menu concerner ici

      // Créer un document dans la collection "commande"
      await FirebaseFirestore.instance.collection('commandes').add({
        'userId': userId,
        'restaurantId': restaurantId,
        'platId': widget.plat['id'], // Assurez-vous que vous avez l'ID du plat
        'quantité': quantity,
        'montant': calculateTotalAmount(),
        'date_heure': FieldValue.serverTimestamp(), // Utilisez un timestamp pour la date de la commande
      });

      // Afficher une boîte de dialogue ou une autre action après l'ajout réussi
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Commande ajoutée avec succès'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Gérer les erreurs d'ajout à Firestore
      print('Erreur lors de l\'ajout à Firestore : $e');
    }
  }


// =============================================================

  @override
  void initState() {
    plats = widget.plat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.plat['data']['nom'];
    // final int prix = int.parse(widget.plat['data']['prix']);
    
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
              stops: [0.9000, 1.2585],
              colors: [
                Colors.white,
                Color.fromARGB(176, 255, 128, 0),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                 const Positioned(
                  top: 0,
                  left: 0,
                  child: BackButton(color: Colors.black),
                ),
                Positioned(
                  top: 20,
                  left: 30,
                  child: SizedBox(
                    height: 50,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                const Positioned(
                  top: 20,
                  right: 0,
                  child: SizedBox(
                    height: 50,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/profil.png'),
                      radius: 30,
                    ),
                  ),
                ),
                const Positioned(
                  top: 100,
                  left: 10,
                  child: Text(
                    'Passez votre commande:',
                    style: TextStyle(
                      color: Color.fromARGB(176, 255, 128, 0),
                      fontSize: 30,
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 150,
                    child: ListView(
                      children: [
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
                        Center(
                            child: SizedBox(
                              width: 200,
                              child: widget.plat['data']["imageUrl"] != null
                                  ? Image.network(
                                      widget.plat['data']["imageUrl"],
                                      fit: BoxFit.cover, // Utilisez BoxFit selon votre mise en page
                                    )
                                  : Image.asset(
                                      'assets/images/placeholder.png', // Remplacez ceci par votre image de substitution
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ignore: prefer_const_constructors
                                Row(
                                  children:  [
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                                    Text(
                                      name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right:90),
                                      child: SizedBox(height: 8),
                                    ),
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                                    Text("${widget.plat['data']['prix']}F CFA",
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Quantité :',
                                      style: TextStyle(
                                        fontSize: 20
                                      ),),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: decrementQuantity,
                                          ),
                                          Text(quantity.toString(),
                                          style: const TextStyle(fontSize: 20),),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: incrementQuantity,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Text('Montant total :',
                                    style: TextStyle(
                                      fontSize: 20
                                    ),),
                                    Padding(
                                      padding: const EdgeInsets.only(left:70.0),
                                      child: Text(
                                        '${calculateTotalAmount()} FCFA',
                                        style:
                                            const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                                            color: Color.fromARGB(255, 255, 153, 0)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed:ajoutCommande,
//====================================== Ajouter la logique pour ajouter l'article
                                      
                                      style: ElevatedButton.styleFrom(
                                       primary: Colors.orange
                                      ),
                                      child: const Text('Ajouter',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25
                                      ),),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
//====================================== Ajouter la logique pour annuler
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .red, // Utiliser une couleur différente pour l'annulation
                                      ),
                                      child: const Text('Annuler',
                                      style: TextStyle(color: Colors.white,
                                      fontSize: 25),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
