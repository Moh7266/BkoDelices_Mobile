import 'package:delice_bko/Pages/plats.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuRestaurant extends StatefulWidget {
  const MenuRestaurant({super.key, required  this.restaurant});
 final Map<String, dynamic> restaurant;
  @override
  State<MenuRestaurant> createState() => _MenuRestaurantState();
}

class _MenuRestaurantState extends State<MenuRestaurant> {
  List<Map<String, dynamic>> restau = [];
   String selectedMenuId = '';

  
  @override
  void initState() {
    super.initState();
    print(widget.restaurant);
    getMenu();
  }

  
getMenu() async {
  try {
    final restaurantId = widget.restaurant['id'];
    final collectionInstance = FirebaseFirestore.instance.collection('restaurants').doc(restaurantId).collection('Menus');

    final snapshot = await collectionInstance.get();
    final val = snapshot.docs.map((doc) => doc.data()).toList();

    print('val:==========');
    print(val);

    // Vérifier si la liste n'est pas vide avant d'essayer d'accéder à son deuxième élément
    if (val.isNotEmpty) {
      // Utiliser plutôt la longueur de la liste directement
      print('Nombre d\'éléments dans la liste : ${val.length}');

      // Afficher les données de chaque élément
      for (var item in val) {

        var plats=item['Plats'];
        print('Données dans la table plats sont : $plats');
      }

      // Mettre à jour l'état avec la liste
      setState(() {
        restau = val;
        print("====================");
        print(restau);
      });
    } else {
      print('La liste est vide.');
    }
  } catch (error) {
    print('Erreur lors de la récupération des menus : $error');
  }
}
// gotoPlat(Map<String, dynamic> restaurant,List<String> plats){


//    Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PagePlats(restaurant: restaurant, plats: plats,)),
//               );

// }

getPlatsForSelectedMenu(String id) async {

  try {
      final collectionInstance = FirebaseFirestore.instance.collection('restaurants').doc(id).collection('Menus').doc(selectedMenuId).collection('Plats');

        final snapshot = await collectionInstance.get();
        final val = snapshot.docs.map((doc) => doc.data()).toList();

        print('Plats pour le menu sélectionné :');
        print(val);
        return val;
    } catch (error) {
      print('Erreur lors de la récupération des plats : $error');
    }
    // try {
    //   if (selectedMenuId.isNotEmpty) {
    //     final restaurantId = widget.restaurant['id'];
    //     final collectionInstance = FirebaseFirestore.instance.collection('restaurants').doc(restaurantId).collection('Menus').doc(selectedMenuId).collection('Plats');

    //     final snapshot = await collectionInstance.get();
    //     final val = snapshot.docs.map((doc) => doc.data()).toList();

    //     print('Plats pour le menu sélectionné :');
    //     print(val);
    //     return val;

    //     // Vous pouvez utiliser ces données comme vous le souhaitez
    //     // Exemple : setState(() { plats = val; });
    //     // Exemple : Navigator.push(context, MaterialPageRoute(builder: (context) => PagePlats(plats: val)));
    //   } else {
    //     print('Aucun menu sélectionné.');
    //   }
    // } catch (error) {
    //   print('Erreur lors de la récupération des plats : $error');
    // }
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
                const Positioned(
                  top: 0,
                  left: 0,
                  child: BackButton(color: Colors.black),
                ),
                Positioned(
                  top: 0,
                  left: 35,
                  child: SizedBox(
                    height: 50,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                const Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    height: 50,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profil.png'),
                      radius: 30,
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
                        suffix: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 15,
                  right: 15,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 90.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: restau.length,
                      itemBuilder: (context, index) {
                        return Card(
  color: Colors.white,
  elevation: 1,
  child: InkWell(
    onTap: () async {
                  // Définir l'ID du menu sélectionné
              // setState(() {
              //   selectedMenuId = restau[index]['id'];
              // });

              // Appeler la méthode pour récupérer les plats du menu sélectionné
              // await getPlatsForSelectedMenu(restau[index]['id']);

              // Naviguer vers la page des plats (PagePlats)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PagePlats(restaurant: restau[index], plats: restau[index]['Plats'] )),
              );
                 },
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                      child: Image.network(
                        restau[index]['imageUrl'] ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        restau[index]['nom'] ?? '',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
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
