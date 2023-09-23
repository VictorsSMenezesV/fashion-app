import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  dynamic id;
  dynamic descricao;
  double? precoCusto;
  dynamic precoVenda;
  dynamic quantidade;
  dynamic valor;
  dynamic quantidadeMaxima;
  dynamic quantidadeMinima;
  dynamic categoria;

  Produto(
      {this.id,
      this.descricao,
      this.precoCusto,
      this.precoVenda,
      this.valor,
      this.quantidade,
      this.quantidadeMinima,
      this.quantidadeMaxima,
      this.categoria
     });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'precoCusto': precoCusto,
      'valor':valor,
      'precoVenda': precoVenda,
      'quantidade': quantidade,
      'quantidadeMaxima': quantidadeMaxima,
      'quantidadeMinima':quantidadeMinima,
      'categoria': categoria
    };
  }

  Produto.fromSnapshot(DocumentSnapshot snapshot) :
      descricao = snapshot['Descricao'];

  Produto.fromMap(Map<String, dynamic> data) {
          id = data["id"];
          descricao = data["descricao"];
          precoCusto = data["precoCusto"];
          valor= data['valor'];
          precoVenda = data["precoVenda"];
          quantidade = data["quantidade"];
           quantidadeMinima = data["quantidadeMinima"];
            quantidadeMaxima = data["quantidadeMaxima"];
            categoria  = data["categoria"];
  }
   


  
}
