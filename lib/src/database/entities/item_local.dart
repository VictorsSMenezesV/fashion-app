class ItemLocal {
  dynamic id;
  dynamic descricao;
  dynamic quantidade;
  dynamic valor;
  dynamic idProd;
  dynamic quantidadeMomento;

  ItemLocal(
      {this.id,
      this.descricao,
    this.valor,
    this.quantidadeMomento,
      this.quantidade,
      this.idProd
     });

  ItemLocal.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    descricao = data['descricao'];
     quantidade = data['quantidade'];
     quantidadeMomento = data['quantidadeMomento'];
      valor = data['valor'];
      idProd = data['idProd'];
   
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    
      'descricao': descricao,
      'quantidadeMomento':quantidadeMomento,
      'idProd': idProd,
      'quantidade': quantidade,
      'valor': valor
     
    };
  }
}
