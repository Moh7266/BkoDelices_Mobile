import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PageAccueil extends StatefulWidget {
  const PageAccueil({Key? key}) : super(key: key);

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  List<Map<String, dynamic>> restau = [];

  Future<void> getData() async {
    QuerySnapshot<Map<String, dynamic>> collectionSnapshot =
        await firestore.collection('restaurants').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in collectionSnapshot.docs) {
      Map<String, dynamic> element = document.data()!;

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
      restau = collectionSnapshot.docs.map((doc) => doc.data()!).toList();
    });

    print(restau);
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
                const Positioned(
                  top: 0,
                  left: 0,
                  child: BackButton(color: Colors.black),
                ),
                Positioned(
                  top: 25,
                  left: 30,
                  child: SizedBox(
                    height: 50,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                const Positioned(
                  top: 25,
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
                  top: 95,
                  right: 15,
                  left: 15,
                  height: 55,
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
                // Add your UI components here based on the 'restau' data
              ],
            ),
          ),
        ),
      ),
    );
  }
}
