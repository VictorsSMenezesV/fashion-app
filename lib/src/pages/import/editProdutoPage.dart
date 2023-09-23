import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_app/src/database/dao/produto_dao.dart';
import 'package:my_app/src/pages/import/adm/barsAdmLayout.dart';
import 'package:my_app/src/pages/import/estoquePage.dart';

class EditProdutoPage extends StatefulWidget {
  dynamic produto;
  dynamic id;
  EditProdutoPage({super.key, required this.id, required this.produto});

  @override
  State<EditProdutoPage> createState() => _EditProdutoPageState();
}

class _EditProdutoPageState extends State<EditProdutoPage> {
  final teste = TextEditingController();
  final _formKey = GlobalKey<FormState>();

final descricao = TextEditingController();
  final precoCusto = TextEditingController();
  final quantidade = TextEditingController();
   final precoVenda = TextEditingController();
    final quantidadeMinima = TextEditingController();
     final quantidadeMaxima = TextEditingController();
        final categoria = TextEditingController();

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    descricao.text = widget.produto['descricao'];
    precoCusto.text = widget.produto['precoCusto'].toString();
    quantidade.text = widget.produto['quantidade'].toString();
    precoVenda.text = widget.produto['precoVenda'].toString();
     quantidadeMinima.text = widget.produto['quantidadeMinima'].toString();
    quantidadeMaxima.text = widget.produto['quantidadeMaxima'].toString();
    categoria.text = widget.produto['categoria'].toString();
  }

  void formatNickname() {
    precoVenda.text = precoVenda.text.replaceAll(",", ".");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Edição de Produto"),
      centerTitle: true,),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Container(
                  height: 150,
                ),
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -40, 0),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [],
                      ),
                    ),
                  ],
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        SizedBox(height: 10),
                        Text(
                          "DESCRIÇÃO:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: descricao,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "QUANTIDADE EM ESTOQUE:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: quantidade,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "QUANTIDADE MÍNIMA:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: quantidadeMinima,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "QUANTIDADE MÁXIMA:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: quantidadeMaxima,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "PREÇO CUSTO:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: precoCusto,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "PREÇO VENDA:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: precoVenda,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "CATEGORIA:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: categoria,
                        ),
                       
                        
                        SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black87,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 70),
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  formatNickname();
                                  DatabaseEstoque.updateUserData(
                                      widget.id,descricao.text,int.parse(quantidade.text),double.parse(precoCusto.text)
                                      ,double.parse(precoVenda.text),int.parse(quantidadeMaxima.text),int.parse(quantidadeMinima.text),categoria.text
                                      );

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const BarsAdmPage()));
                                },
                                child: Text("Salvar")),
                          ],
                        ),
                        SizedBox(height: 30),
                        _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.amber),
                              )
                            : SizedBox.shrink()
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
