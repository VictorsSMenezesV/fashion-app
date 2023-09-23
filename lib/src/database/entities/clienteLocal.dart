// ignore: file_names
class Cliente {
  dynamic id;
  String? endereco;
  String? telefone;
  String? email;
  String? nome;

  Cliente(
      {this.id,
     this.endereco,
      this.telefone,
      this.email,
      this.nome});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
      'email': email,
    };
  }

  Cliente.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    nome = data['nome'];
    endereco = data['endereco'];
    telefone = data['telefone'];
    email = data['email'];
  }

  Cliente copy(
          {int? id,
          String? nome,
          String? endereco,
          String? telefone,
          String? email,
}) =>
      Cliente(
          id: id ?? this.id,
          nome: nome ?? this.nome,
          endereco: endereco ?? this.endereco,
          telefone: telefone ?? this.telefone,
          email: email ?? this.email);
}
