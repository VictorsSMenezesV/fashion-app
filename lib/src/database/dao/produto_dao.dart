import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference _mainCollection = _firestore.collection("prods");

class DatabaseEstoque {
  static String? userId;

  static Future<void> addItem({
    required String descricao,
    required int quantidade,
    required double precoCusto,
    required double precoVenda,
    required int quantidadeMaxima,
    required int quantidadeMinima,
    required String forncecedor,
    required String codigoBarras,
    required String categoria,
    
  }) async {
    DocumentReference documentReference = _mainCollection.doc(userId);

    Map<String, dynamic> data = <String, dynamic>{
      "descricao": descricao,
      "quantidade": quantidade,
      "precoCusto": precoCusto,
      "precoVenda": precoVenda,
      "quantidadeMaxima": quantidadeMaxima,
      "quantidadeMinima": quantidadeMinima,
      "forncecedor": forncecedor,
      "codigoBarras": codigoBarras,
      "categoria": categoria,
      
    };
    await documentReference
        .set(data)
        .whenComplete(() => print(" NOTE ITEM INSERT"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference itensCollection = _firestore.collection("prods");
    return itensCollection.snapshots();
  }
  static Stream<QuerySnapshot> readItems2() {
    CollectionReference itensCollection = _firestore.collection("vendedores");
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

  static void updateUserData(
      dynamic id, String descricao,
     int quantidade,
     double precoCusto,
     double precoVenda,
     int quantidadeMaxima,
     int quantidadeMinima,
     
     String categoria,) {
    _mainCollection.doc(id).update({
       "descricao": descricao,
      "quantidade": quantidade,
      "precoCusto": precoCusto,
      "precoVenda": precoVenda,
      "quantidadeMaxima": quantidadeMaxima,
      "quantidadeMinima": quantidadeMinima,
      "categoria": categoria,
      
    });
  }
  static void updateEstoque(
    dynamic id, 
    dynamic quantidade,
    ) {
    _mainCollection.doc(id).update({
      "quantidade": quantidade,     
    });
  }

  static Future<void> addtoCart(
      dynamic id, dynamic nome, dynamic valorP, dynamic quantidade) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("vend");
    return collectionRef
        .doc(id)
        .collection("itens")
        .doc()
        .set({"descricao": nome, "valor": valorP, "quantidade": quantidade})
        .whenComplete(() => print("Inserido"))
        .catchError((e) => print(e));
  }
}
