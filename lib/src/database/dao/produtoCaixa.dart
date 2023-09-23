import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoCaixa{

 int? id;
  dynamic descricao;
  double? valor;
  int? quantidade;
 

  ProdutoCaixa(
      {this.id,
      this.descricao,
      this.valor,
      this.quantidade,
     });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'quantidade': quantidade,
      
    };
  }

  ProdutoCaixa.fromSnapshot(DocumentSnapshot snapshot) :
      descricao = snapshot['Descricao'];

  ProdutoCaixa.fromMap(Map<String, dynamic> data) {
          id = data["id"];
          descricao = data["descricao"];
          valor = data["valor"];
          quantidade = data["quantidade"];
           
  }
   


  
}
