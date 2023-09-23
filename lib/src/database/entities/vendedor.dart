import 'package:cloud_firestore/cloud_firestore.dart';

class Vendedor{
  dynamic id;
  dynamic nome;
  dynamic email;
  dynamic telefone;
  

  Vendedor(
      {this.id,
      this.nome,
      this.email,
      this.telefone,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      
    };
  }

  Vendedor.fromSnapshot(DocumentSnapshot snapshot) :
      nome = snapshot['nome'];

  Vendedor.fromMap(Map<String, dynamic> data) {
    id = data["id"];
        nome = data["nome"];
         email = data["email"];
          telefone = data["telefone"];
  }
   

  @override
  String toString() {
    return 'Produto{ID: $id, DESCRICAO: $nome, CUSTO:$email, VALOR: $telefone}';
  }

  Vendedor.e(dynamic obj) {
    id = obj['id'];
    nome = obj['DESCRICAO'];
    email = obj['email'];
    telefone = obj['telefone'];
    ;
  }
}
