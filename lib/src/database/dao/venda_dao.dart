import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference _mainCollection = _firestore.collection("vendas");

class VendasDatabase {
  static String? userId;

  static Future<void> addItem({
    required String comprador,
    required String endereco,
  }) async {
    DocumentReference documentReference = _mainCollection.doc(userId);

    Map<String, dynamic> data = <String, dynamic>{
      "comprador": comprador,
      "endereco": endereco,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print(" NOTE ITEM INSERT"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference itensCollection = _firestore.collection("vendas");
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

  static addtoCart(String id, String nome, double valor, int quantidade) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("vendas");

    collectionRef
        .doc(id)
        .collection("itens")
        .doc()
        .set({"descricao": nome, "valor": valor, "quantidade": quantidade})
        .whenComplete(() => print("Inserido"))
        .catchError((e) => print(e));
  }
}
