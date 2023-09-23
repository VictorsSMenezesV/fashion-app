import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference _mainCollection = _firestore.collection("vendedores");
class VendedorDatabase{
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
      String email) {
    _mainCollection.doc(id).update({
      'nome': nome,
      'telefone': telefone,
      'email': email,
   
      
    });
  }
}