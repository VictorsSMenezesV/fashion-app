import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/src/database/entities/clienteLocal.dart';

class FirestoreHelper {
  static Future delete(Cliente user) async {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final docRef = userCollection.doc(user.id).delete();
  }
}
