import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/database/dao/produto_dao.dart';
import 'package:my_app/src/database/entities/clienteLocal.dart';
import 'package:my_app/src/database/entities/item_local.dart';
import 'package:my_app/src/database/entities/produto_local.dart';
import 'package:my_app/src/database/entities/venda_local.dart';
import 'package:my_app/src/pages/import/estoquePage.dart';
import 'package:my_app/src/pages/import/testeCarito.dart';
import 'package:uuid/uuid.dart';

import 'import/caixaPage.dart';

class SelectProductPage extends StatefulWidget {
 dynamic item;
  dynamic vendedor;
  dynamic idVendedor;
  
 SelectProductPage({super.key, required this.item, required this.vendedor, required this.idVendedor});

  @override
  State<SelectProductPage> createState() => _SelectProductPageState();
}

class _SelectProductPageState extends State<SelectProductPage> {
    List<Produto> listListins = [];
 List<Produto> teste = [];
  TextEditingController seachtf = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  dynamic total;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
 
  @override
  void initState() {
    
    teste = listListins;
    refresh();
   
    super.initState();
  }

addtoCart(dynamic id, dynamic nome, dynamic valor, dynamic quantidade){
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("vend");
    collectionRef
        .doc(id)
        .collection("itens")
        .doc()
        .set({"descricao": nome, "valor": valor, "quantidade": quantidade})
        .whenComplete(() => print("Inserido"))
        .catchError((e) => print(e));
  }

  String name = "";
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: (listListins.isEmpty)
          ? const Center(
              child: Text(
                "Produtos",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ) : Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: TextField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Pesquisar...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        )
      ),
      
      body: (listListins.isEmpty)
          ? const Center(
              child: Text(
                "Carregando lista de produtos....",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
            children: [
               Expanded(
                    child: ListView(
                      shrinkWrap:  true,
                      children: List.generate(
                        listListins.length, (index) {
                           Produto model2 = listListins[index];
                          if(name.isEmpty){
                           return ListTile(
                  title: Text(model2.descricao,
                      style: TextStyle(fontSize: 25)),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Preço: ${model2.precoVenda.toString()}',
                          style: TextStyle(fontSize: 20)),
                      Text(
                        'Quantidade: ${model2.quantidade.toString()}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                        width: 50,
                      ),
                      SizedBox(
                        height: 20,
                        width: 50,
                      ),
                      SizedBox(
                        height: 20,
                        width: 50,
                      )
                    ],
                  ),
                  trailing: MaterialButton(
                    color: Colors.black87,
                    textColor: Colors.white,
                    child: const Text('Adicionar'),
                    onPressed: () {
                     print("IDDD AQUI ${model2.id}");
                      seachtf.clear();

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Quantidade'),
                                content: TextField(
                                  decoration: const InputDecoration(
                                      labelText: 'Quantidade'),
                                  keyboardType: TextInputType.number,
                                  controller: quantidadeController,
                                ),
                                actions: [
                                  MaterialButton(
                                      color: Colors.black87,
                                      textColor: Colors.white,
                                      child: const Text('Confirmar'),
                                      onPressed: () async{
                                         dynamic teste = model2.quantidade - double.parse(quantidadeController.text);
                                         DatabaseEstoque.updateEstoque(model2.id,teste);
                                        // seachtf.clear();
                                   
                            
                                                       
                        ItemLocal itemLocal = ItemLocal(
                        id: const Uuid().v1(),
                       descricao: model2.descricao.toString(),
                       valor: model2.precoVenda,
                       quantidade: double.parse(quantidadeController.text)
                       ,idProd: model2.id,
                       quantidadeMomento: model2.quantidade
                      );
                        

                      // Salvar no Firestore
                      
                    FirebaseFirestore.instance.collection("vend")
                          .doc(widget.item).collection("itens").doc(itemLocal.id)
                          .set(itemLocal.toMap());
      
                            
                                 
                                      
                                         setState(() {
                                            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CardPage3(
                                item: widget.item.toString(), vendedor: widget.vendedor, idVendedor: widget.idVendedor,
                              )));
                                         });
                                   
                                      
                                      

                                        quantidadeController.clear();

                                        // bye(lista[index].id as dynamic);
                                      }),
                                  MaterialButton(
                                    color: Colors.black87,
                                    textColor: Colors.white,
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                    },
                  ),
                );
                          }  if(model2.descricao
                          .toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase())){
                             return ListTile(
                  title: Text(model2.descricao,
                      style: TextStyle(fontSize: 25)),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Preço: ${model2.precoVenda.toString()}',
                          style: TextStyle(fontSize: 20)),
                      Text(
                        'Quantidade: ${model2.quantidade.toString()}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                        width: 50,
                      ),
                      SizedBox(
                        height: 20,
                        width: 50,
                      ),
                      SizedBox(
                        height: 20,
                        width: 50,
                      )
                    ],
                  ),
                  trailing: MaterialButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: const Text('Adicionar'),
                    onPressed: () {
                     
                      seachtf.clear();

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Quantidade'),
                                content: TextField(
                                  decoration: const InputDecoration(
                                      labelText: 'Quantidade'),
                                  keyboardType: TextInputType.number,
                                  controller: quantidadeController,
                                ),
                                actions: [
                                  MaterialButton(
                                      color: Colors.red,
                                      textColor: Colors.white,
                                      child: const Text('Confirmar'),
                                      onPressed: () async{
                                          dynamic teste = model2.quantidade - double.parse(quantidadeController.text);
                                         DatabaseEstoque.updateEstoque(model2.id,teste);
                                        // seachtf.clear();
                                        print(teste);
                                        try{
                        addtoCart(widget.item,model2.descricao,model2.precoVenda,double.parse(quantidadeController.text));

                                          }catch(e){
                                            print("Segundo");
                                            print(e);
                                          }
                                      
                                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CardPage3(
                                item: widget.item.toString(), vendedor: widget.vendedor, idVendedor: widget.idVendedor,
                              )));
                                      

                                        quantidadeController.clear();

                                        // bye(lista[index].id as dynamic);
                                      }),
                                  MaterialButton(
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                    },
                  ),
                );
                          }else{
                            return Container();
                          }
                        }),
                    ),)
            ],
          )
    );
  }

refresh() async {
    List<Produto> temp2 = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('prods')
        .where(
          'descricao',
          isGreaterThanOrEqualTo: seachtf.text,
        )
        .get();
        final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('prods')
        .where(
          'descricao',
          isGreaterThanOrEqualTo: seachtf.text,
        )
        .snapshots();

    for (var doc in snapshot.docs) {
      temp2.add(Produto.fromMap(doc.data()));
    }

    setState(() {
      listListins = temp2;
    });
  }
}