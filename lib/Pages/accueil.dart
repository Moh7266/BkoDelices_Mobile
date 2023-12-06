import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delice_bko/Pages/Menu.dart';
import 'package:delice_bko/Services/currentUser.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PageAccueil extends StatefulWidget {
  const PageAccueil({Key? key}) : super(key: key);

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

void main() async {
  CurrentUser currentUser = CurrentUser();
  String userName = await currentUser.getUser();
  print('Nom de l\'utilisateur : $userName');
}

class _PageAccueilState extends State<PageAccueil> {

   bool isLoading = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  List<Map<String, dynamic>> restau = [];

  Future<void> getData() async {
     setState(() {
                    isLoading = true; // Démarre l'indicateur de chargement
                  });

    QuerySnapshot<Map<String, dynamic>> collectionSnapshot =
        await firestore.collection('restaurants').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in collectionSnapshot.docs) {
      Map<String, dynamic> element = document.data();

      Reference storageRef = storage.ref('images/${element['id']}');
      

      try {
        String url = await storageRef.getDownloadURL();
        element['fileInput'] = url;
      } catch (e) {
        print('Error fetching image URL: $e');
      }
    }

    setState(() {
      // Update the state with the fetched data
      restau = collectionSnapshot.docs.map((doc) => doc.data()).toList();
    });

    print(restau);
    setState(() {
    isLoading = false; // Arrête l'indicateur de chargement
  });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
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
                Positioned(
                  top: 20,
                  left: 25,
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
                  // Indicateur de chargement
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
                const Positioned(
                  top: 90,
                  right: 15,
                  left: 15,
                  height: 45,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Rechercher...',
                        suffix: Icon(Icons.search,),                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          
                          
                        ),
                      ),
                    ),
                  ),
                ),
                // Add your UI components here based on the 'restau' data

                 Positioned(
                      top: 150,
                      left: 15,
                      right: 15,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:90.0),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0, // Ajustez selon vos préférences
                            mainAxisSpacing: 10.0, // Ajustez selon vos préférences
                          ),
                          itemCount: restau.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('La carte ${restau[index]['nom']} a été cliquée!');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>MenuRestaurant(restaurant:restau[index]))
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 1, // Ajustez selon vos préférences
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      child: Image.network(
                                        restau[index]['imageUrl'] ?? '',
                                        fit: BoxFit.cover,
                                        // height: 150, // Ajustez selon vos préférences
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        restau[index]['nom'] ?? '',
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // Ajoutez d'autres widgets pour afficher d'autres détails du restaurant
                                  ],
                                ),
                              ),
                            );
                          },
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
