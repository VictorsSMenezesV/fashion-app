import 'package:cloud_firestore/cloud_firestore.dart';

class VendaUnica{

int? id;
  dynamic dataVenda;
  dynamic desconto;
  dynamic itens;
  dynamic valorBonus;
  dynamic valorTotal;
  
  VendaUnica(
      {this.id,
      this.dataVenda,
      this.desconto,
      this.itens,
      this.valorBonus,
      this.valorTotal});

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'DESCRICAO': dataVenda,
      'CUSTO': desconto,
      'VALOR': itens,
      'VALOR_MINIMO': valorBonus,
      'QUANTIDADE_ATUAL': valorTotal
    };
  }

  VendaUnica.fromSnapshot(DocumentSnapshot snapshot) :
      desconto = snapshot['desconto'];

  VendaUnica.fromMap(Map<String, dynamic> data) {
    id = data["id"];
        dataVenda = data["dataVenda"];
         desconto = data["desconto"];
          itens = data["itens"];
          valorBonus = data["valorBonus"];
          valorTotal = data["valorTotal"];
  }
   

 

  VendaUnica.e(dynamic obj) {
    id = obj['ID'];
     dataVenda = obj["dataVenda"];
         desconto = obj["desconto"];
          itens = obj["itens"];
          valorBonus = obj["valorBonus"];
          valorTotal = obj["valorTotal"];
  }
}
