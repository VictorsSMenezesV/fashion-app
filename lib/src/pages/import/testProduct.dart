import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_app/src/pages/import/carinhoTest.dart';
import 'package:my_app/src/database/dao/produto_dao.dart';
import 'package:my_app/src/database/dao/venda_dao.dart';
import 'package:my_app/src/pages/import/caixaPage.dart';
import 'package:my_app/src/pages/import/testeCarito.dart';

class SelectProduct extends StatefulWidget {
  dynamic item;
  SelectProduct({super.key, required this.item});

  @override
  State<SelectProduct> createState() => _SelectProductState();
}

class _SelectProductState extends State<SelectProduct> {
  TextEditingController seachtf = TextEditingController();
  final quantidadeController = TextEditingController();

  addtoCart(String id, String nome, double valor, double quantidade) {
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

  removeQuantidade(dynamic id, dynamic quantiade) {
    CollectionReference teste =
        FirebaseFirestore.instance.collection('produtos');
    return teste.doc(id).update({"quantidade": quantiade});
  }

  dynamic teste;

  @override
  void initState() {
    teste = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('prods')
        .where(
          'descricao',
          isGreaterThanOrEqualTo: seachtf.text,
        )
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CardPage3(
                                item: widget.item, vendedor: "Nenhum", idVendedor: "",
                              )));
                });
              },
              icon: const Icon(Icons.local_grocery_store_rounded))
        ],
        title: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: TextField(
            controller: seachtf,
            decoration: InputDecoration(
              hintText: 'NOVO CAIXA',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                var preco = snapshot.data!.docChanges[index].doc['precoVenda'];

                var quantidade =
                    snapshot.data!.docChanges[index].doc['quantidade'];
                var nome = snapshot.data!.docChanges[index].doc['descricao'];
                var docID = snapshot.data!.docs[index].id;
                return Card(
                    child: ListTile(
                  title: Text(snapshot.data!.docChanges[index].doc['descricao'],
                      style: TextStyle(fontSize: 25)),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Preço: ${preco.toString()}',
                          style: TextStyle(fontSize: 20)),
                      Text(
                        'Quantidade: ${quantidade.toString()}',
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
                                        // seachtf.clear();

                                      await  addtoCart(widget.item,nome,preco,double.parse(quantidadeController.text));
                                      setState(() {
                                        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CardPage3(
                                item: widget.item, vendedor: "Nenhum", idVendedor: "",
                              )));
                                      });

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
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
