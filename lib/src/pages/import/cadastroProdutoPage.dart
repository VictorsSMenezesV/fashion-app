import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_app/src/database/dao/produto_dao.dart';
import 'package:my_app/src/database/entities/produto_local.dart';
import 'package:my_app/src/pages/import/adm/barsAdmLayout.dart';
import 'package:my_app/src/pages/import/estoquePage.dart';
import 'package:uuid/uuid.dart';

class CadastroProductPage extends StatefulWidget {
  const   CadastroProductPage({super.key});

  @override
  State<CadastroProductPage> createState() => _CadastroProductPageState();
}

class _CadastroProductPageState extends State<CadastroProductPage> {
  final descricao = TextEditingController();
  final precoCusto = TextEditingController();
  final quantidade = TextEditingController();
   final precoVenda = TextEditingController();
    final quantidadeMinima = TextEditingController();
     final quantidadeMaxima = TextEditingController();
      final fonrecedor = TextEditingController();
       final codigoBarras = TextEditingController();
        final categoria = TextEditingController();
  void formatNickname() {
    precoCusto.text = precoCusto.text.replaceAll(",", ".");
    precoVenda.text = precoVenda.text.replaceAll(",", ".");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Cadastro de Produto"),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 25,
            width: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
          Expanded(
            child: Container(
              width: 1800,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: descricao,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'DESCRIÇÃO',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                   
                     
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                Icons.payments_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: precoCusto,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'PREÇO CUSTO',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                Icons.payments_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: precoVenda,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'PREÇO VENDA',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                Icons.view_list,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: quantidade,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'QUANTIDADE EM ESTOQUE',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                Icons.view_list,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: quantidadeMaxima,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'QUANTIDADE MAXIMA',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                Icons.view_list,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: quantidadeMinima,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'QUANTIDADE MINIMA',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                Icons.view_list,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: categoria,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'CATEGORIA',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 20,
                        height: 60,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 70),
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          formatNickname();

                           Produto produto = Produto(
                        id: const Uuid().v1(),
                       descricao: descricao.text,quantidade: int.parse(quantidade.text)
                          ,categoria: categoria.text,precoCusto: double.parse(precoCusto.text)
                          ,precoVenda:double.parse(precoVenda.text) ,quantidadeMaxima: int.parse( quantidadeMaxima.text),quantidadeMinima: int.parse( quantidadeMinima.text),valor: double.parse(precoVenda.text) 
                      );
                        

                      // Salvar no Firestore
                      
                    FirebaseFirestore.instance.collection("prods")
                          .doc(produto.id)
                          .set(produto.toMap());
                        

                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const BarsAdmPage()));
                          });
                        },
                        child: const Text("CADASTRAR"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
