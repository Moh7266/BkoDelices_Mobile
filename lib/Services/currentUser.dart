import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";


class CurrentUser {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   Future<String> getUser() async {
    try {
      final User? user = _auth.currentUser;

      if (user != null) {
        final String uid = user.uid;
        final DocumentSnapshot document = await _firestore.collection('utilisateur').doc(uid).get();
        if (document.exists) {
          final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          final String nom = data['nom'];

          return nom;
        } else {
          return 'Nom non trouvé';
        }
      } else {
        return 'Utilisateur non connecté';
      }
    } catch (e) {
      print('Erreur lors de la récupération du nom de l\'utilisateur : $e');
      return 'Erreur';
    }
  }

}