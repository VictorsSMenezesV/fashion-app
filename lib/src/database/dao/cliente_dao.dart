import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/src/database/entities/clienteLocal.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference _mainCollection = _firestore.collection("clientes");

class Database {
  static String? userId;

  static Future<void> addItem({
    required String nome,
    required String endereco,
    required String telefone,
    required String email,
  }) async {
    DocumentReference documentReference = _mainCollection.doc(userId);

    Map<String, dynamic> data = <String, dynamic>{
      "nome": nome,
      "endereco": endereco,
      "telefone": telefone,
      "email": email,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print(" NOTE ITEM INSERT"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference itensCollection = _firestore.collection("clientes");
    return itensCollection.snapshots();
  }

  static Stream<QuerySnapshot> readItems2(dynamic id) {
    CollectionReference itensCollection = _firestore.collection("vend").doc(id).collection("itens");
    return itensCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docID,
  }) async {
    DocumentReference documentReference = _mainCollection.doc(docID);

    await documentReference
        .delete()
        .whenComplete(() => print(" Deletado"))
        .catchError((e) => print(e));
  }

  static void updateUserData(dynamic id, String nome, String telefone,
      String email, String endereco) {
    _mainCollection.doc(id).update({
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'endereco': endereco,
      
    });
  }
}
