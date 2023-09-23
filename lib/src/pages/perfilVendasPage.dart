import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_app/src/pages/vendasPage.dart';

class PerfilVendaPage extends StatefulWidget {
  dynamic item;
  PerfilVendaPage({super.key, required this.item});

  @override
  State<PerfilVendaPage> createState() => _PerfilVendaPageState();
}

class _PerfilVendaPageState extends State<PerfilVendaPage> {
  void buscar(dynamic id) async {}

  bye(int id) async {
    return null; //ItemLocalDAO().deleteData(id);
  }

//  var userService = ItemLocalDAO();
//  var userService2 = VendasLocalDAO();

  List<String> status = ['ORCAMENTO', 'ENVIADO'];
  dynamic status2;

  /*
  FlatButton(
                                          child: const Text('Sim'),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ObsPage(
                                                              valor: widget
                                                                  .item)));
                                            });
                                          }),
                                      FlatButton(
                                        child: const Text('Não'),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          const TableLayout()));







                                                          ///////////////////##############################////////////////
                                                      

                                                       FlatButton(
                                                                      child: const Text(
                                                                          'Sim'),
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          bye(lista[index].id
                                                                              as dynamic);
                                                                        });

                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }),
                                                                  FlatButton(
                                                                    child: const Text(
                                                                        'Não'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                        },
                                      ),
                                    */

  dynamic idE;

  @override
  void initState() {
    status2 = status;
    idE = widget.item;
    super.initState();
  }

  Future<bool> saved() async {
    return false;
  }

  Future<QuerySnapshot> buscar2(dynamic id) {
    return FirebaseFirestore.instance
        .collection('vendas')
        .doc(id.toString())
        .collection("itens")
        .get();
  }

  Future<void> quantidadeup(
      dynamic id1, dynamic id2, dynamic quantidade) async {
    return await FirebaseFirestore.instance
        .collection('vendas')
        .doc(id1)
        .collection("itens")
        .doc(id2)
        .update({"Quantidade": quantidade});
  }

  Future<void> delete(dynamic id1, dynamic id2) async {
    await FirebaseFirestore.instance
        .collection('vendas')
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
    dynamic valor;
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
        future: buscar2(widget.item),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.black12,
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Venda'),
                backgroundColor: Colors.red,
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
                              padding: const EdgeInsets.all(8.0),
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
                                  Text("Quantidade: ${quantidade.toString()}",
                                      style: const TextStyle(fontSize: 16)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [],
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
