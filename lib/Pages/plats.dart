import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delice_bko/Pages/passecommande.dart';
import 'package:flutter/material.dart';

class PagePlats extends StatefulWidget {
  const PagePlats({Key? key, required this.restaurant, required this.plats}) : super(key: key);

  final Map<String, dynamic> restaurant;
  final List plats;

  @override
  _PagePlatsState createState() => _PagePlatsState();
}

class _PagePlatsState extends State<PagePlats> {
  List<Map<String, dynamic>> plats = [];
  Future<List<Map<String, dynamic>>> mesPlats = Future(() => List.empty());

  @override
  void initState() {
    mesPlats = infoPlats(widget.plats);
    super.initState();
  }

  Future<List<Map<String, dynamic>>> infoPlats(List plats) async {
    List<Map<String, dynamic>> mesPlats = [];
    try {
      for (var id in plats) {
        final data = await FirebaseFirestore.instance.collection('plats').doc(id).get();
        mesPlats.add(Map.from({"id": data.id, "data": data.data()}));
      }
      return mesPlats;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _showPlatDetailsDialog(Map<String, dynamic> plat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(plat["data"]['nom'] ?? ''),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 90,
                child: plat["data"]['imageUrl'] != null
                    ? Image.network(
                        plat["data"]['imageUrl'],
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/food.png',
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Description: ${plat["data"]['description'] ?? ''}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Prix: ${plat["data"]['prix'] ?? ''} FCFA',
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
              // Ajoutez d'autres détails du plat si nécessaire
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
               Navigator.push(
                context,
                  MaterialPageRoute(builder: (context)=> PasseCommande(plat:plat))
                );
              },
              child: const Text('Commander'),
            ),
          ],
        );
      },
    );
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
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: mesPlats,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text("Aucune donnée retrouvée !"),
                      );
                    } else {
                      plats = snapshot.data!;
                      print(plats.toString());
                      return Positioned(
                        top: 150,
                        left: 15,
                        right: 15,
                        bottom: 0,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: plats.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> plat = plats[index];
                            return Positioned(
                              top: 120,
                              left: 15,
                              right: 15,
                              bottom: 0,
                              child: Card(
                                color: Colors.white,
                                elevation: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    _showPlatDetailsDialog(plat);
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 90,
                                        child: plat["data"]['imageUrl'] != null
                                            ? Image.network(
                                                plat["data"]['imageUrl'],
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/food.png',
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              plat["data"]['nom'] ?? '',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Prix: ${plat["data"]['prix'] ?? ''} FCFA',
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
