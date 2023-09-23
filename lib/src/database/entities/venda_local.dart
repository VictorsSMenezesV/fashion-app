class VendaLocal {
  int? id;
  int? idClienteLocal;
  String? comprador;
  String? telefone;
  String? email;
  int? idCondicaoPagamento;
  int? itens;
  dynamic valorCusto;
  dynamic valorOriginal;
  dynamic valorFinal;
  String? dataEmissao;
  String? obsCliente;
  String? obsLogistica;
  String? obsFaturamento;
  String? status;

  VendaLocal(
      {this.id,
      this.idClienteLocal,
      this.comprador,
      this.telefone,
      this.email,
      this.idCondicaoPagamento,
      this.itens,
      this.valorCusto,
      this.valorOriginal,
      this.valorFinal,
      this.dataEmissao,
      this.obsCliente,
      this.obsLogistica,
      this.obsFaturamento,
      this.status});

  VendaLocal.fromMap(Map<String, dynamic> data) {
    id = data['ID'];
    idClienteLocal = data['ID_CLIENTE_LOCAL'];
    comprador = data['COMPRADOR'];
    telefone = data['TELEFONE'];
    email = data['EMAIL'];
    idCondicaoPagamento = data['ID_CONDICAO_PAGAMENTO'];
    itens = data['ITENS'];
    valorCusto = data['VALOR_CUSTO'];
    valorOriginal = data['VALOR_ORIGINAL'];
    valorFinal = data['VALOR_FINAL'];
    dataEmissao = data['DATA_EMISSAO'];
    obsCliente = data['OBS_CLIENTE'];
    obsLogistica = data['OBS_LOGISTICA'];
    obsFaturamento = data['OBS_FATURAMENTO'];
    status = data['STATUS'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'ID_CLIENTE_LOCAL': idClienteLocal,
      'COMPRADOR': comprador,
      'TELEFONE': telefone,
      'EMAIL': email,
      'ID_CONDICAO_PAGAMENTO': idCondicaoPagamento,
      'ITENS': itens,
      'VALOR_CUSTO': valorCusto,
      'VALOR_ORIGINAL': valorOriginal,
      'VALOR_FINAL': valorFinal,
      'DATA_EMISSAO': dataEmissao,
      'OBS_CLIENTE': obsCliente,
      'OBS_LOGISTICA': obsLogistica,
      'OBS_FATURAMENTO': obsFaturamento,
      'STATUS': status
    };
  }
}
