import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:my_app/src/pages/import/testProduct.dart';


// ignore: must_be_immutable
class CardPage extends StatefulWidget {
  dynamic item;
  CardPage({Key? key, required this.item}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  void buscar(dynamic id) async {}

  bye(int id) async {
    return null; //ItemLocalDAO().deleteData(id);
  }

  Future<List<String>> fetchDataFromFirebase() async {
  List<String> dataList = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('vendedores').get();

  querySnapshot.docs.forEach((doc) {
    dataList.add(doc['nome']); // Replace 'field_name' with the name of the field in your Firestore document
  });

  return dataList;
}
List<String> dataLis = [];


  List<String> status = ['Vendedor 1', 'Vendedor 2'];
  dynamic status2 ;

  

  dynamic idE;

  @override
  void initState() {
   dataLis = fetchDataFromFirebase() as List<String>;
    status2 = status;
    idE = widget.item;
    super.initState();
  }

  Future<bool> saved() async {
    return false;
  }

  void valorFinal(dynamic id, double valorFinal) {
    FirebaseFirestore.instance
        .collection('vend')
        .doc(id)
        .update({'valorFinal': valorFinal});
  }

  Future<QuerySnapshot> buscar2(dynamic id)async {
    return await FirebaseFirestore.instance
        .collection('vend')
        .doc(id.toString())
        .collection("itens")
        .get();
  }

  Future<void> quantidadeup(
      dynamic id1, dynamic id2, dynamic quantidade) async {
    return await FirebaseFirestore.instance
        .collection('vend')
        .doc(id1)
        .collection("itens")
        .doc(id2)
        .update({"quantidade": quantidade});
  }

  Future<void> delete(dynamic id1, dynamic id2) async {
    await FirebaseFirestore.instance
        .collection('vend')
        .doc(id1)
        .collection("itens")
        .doc(id2)
        .delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Apagado com sucesso")));
  }

  Future<void> _update(dynamic valor1, dynamic valor2) async {
    final teste = FirebaseFirestore.instance.collection('vendas');

    await teste
        .doc(widget.item)
        .update({'valorFinal': valor1, 'itens': valor2});
  }

 
  @override
  Widget build(BuildContext context) {
    dynamic valor ;
    dynamic total;
    dynamic total2;
    dynamic total3;

    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Sair do Aplicativo'),
              content: const Text('Voçê deseja sair do aplicativo?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Sim'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Não'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return FutureBuilder(
        future: buscar2("CAPuvCTEJ07NsME8ZeBK"),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.black12,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SelectProduct(
                                    item: widget.item,
                                  )));
                    });

                    print(widget.item);
                  }),
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.red,
                actions: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Adicionar Vendedor?'),
                                  content: const Text(
                                      'Deseja adicionar?'),
                                  actions: [
                                    MaterialButton(
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        child: const Text('Sim'),
                                        onPressed: () {
                                         
                                        }),
                                    MaterialButton(
                                      color: Colors.red,
                                      textColor: Colors.white,
                                      child: const Text('Não'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.check))
                ],
                title: const Text('Carrinho'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final dynamic tes = streamSnapshot.data!.docs[index];
                        var noteInfo = streamSnapshot.data?.docs[index].data()
                            as Map<String, dynamic>;
                        var docID = streamSnapshot.data?.docs[index].id;
                        var nome = noteInfo['descricao'];
                        var preco = noteInfo['valor'];
                        var quantidade = noteInfo['quantidade'];

                        return Card(
                          child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Descrição: $nome",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 15),
                                  Text("Preço: ${preco.toString()}",
                                      style: const TextStyle(fontSize: 16)),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text("Quantidade: ${quantidade.toString()} ",
                                      style: const TextStyle(fontSize: 16)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          IconButton(
                                              color: Colors.red,
                                              iconSize: 35,
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: const Text(
                                                              'Excluir Item'),
                                                          content: const Text(
                                                              'Deseja excluir o item do carrinho?'),
                                                          actions: [
                                                            MaterialButton(
                                                                color:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    const Text(
                                                                        'Sim'),
                                                                onPressed:
                                                                    () async {
                                                                  await delete(
                                                                      widget
                                                                          .item,
                                                                      tes.id);
                                                                  setState(() {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  });
                                                                }),
                                                            MaterialButton(
                                                              color: Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              child: const Text(
                                                                  'Não'),
                                                              onPressed: () {},
                                                            ),
                                                          ],
                                                        ));
                                              },
                                              icon: const Icon(Icons.delete))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                    
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 1),
                          ),
                          Row(
                            children: [
                              Text(
                                  'Total: ${total = streamSnapshot.data!.docs.map((product) => product['valor'] * product['quantidade']).toList().reduce((value, element) => value + element).toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 190),
                              Text(''),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Scaffold();
          }
        });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ));
}
/*${total3 = lista.isNotEmpty ? lista.map<double>((e) => e.custoUnitario * e.quantidade).reduce((value, element) => value + element).toStringAsFixed(2) : 0}
${total = lista.isNotEmpty ? lista.map<int>((e) => e.quantidade as dynamic).reduce((value, element) => value + element).toStringAsFixed(0) : 0}
${total2 = lista.isNotEmpty ? lista.map<double>((e) => e.valorOriginal * e.quantidade).reduce((value, element) => value + element).toStringAsFixed(2) : 0}



segundo ${total = lista.isNotEmpty ? lista.map<int>((e) => e.quantidade as dynamic).reduce((value, element) => value + element).toStringAsFixed(0) : 0}

terceiro ${total2 = lista.isNotEmpty ? lista.map<double>((e) => e.valorOriginal * e.quantidade).reduce((value, element) => value + element).toStringAsFixed(2) : 0}


*/