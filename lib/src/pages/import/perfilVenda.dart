import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/pages/vendasPage.dart';

class PerfilVenda extends StatefulWidget {
  dynamic formaDePagamento;
  dynamic item;
   PerfilVenda({super.key,required this.item,required this.formaDePagamento});

  @override
  State<PerfilVenda> createState() => _PerfilVendaState();
}

class _PerfilVendaState extends State<PerfilVenda> {
   void buscar(dynamic id) async {}

  bye(int id) async {
    return null; //ItemLocalDAO().deleteData(id);
  }



  List<String> status = ['ORCAMENTO', 'ENVIADO'];
  dynamic status2;

 

  dynamic idE;

  @override
  void initState() {
    status2 = status;
    //idE = widget.item;
    super.initState();
  }

  Future<bool> saved() async {
    return false;
  }

  void valorFinal(dynamic id, double valorFinal) {
    FirebaseFirestore.instance
        .collection('vendas')
        .doc(id)
        .update({'valorFinal': valorFinal});
  }

  Future<QuerySnapshot> buscar2(dynamic id) {
    return FirebaseFirestore.instance
        .collection('vend')
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.black87,
                  child: const Icon(Icons.check),
                  onPressed: () {
                    Navigator.of(context).pop();

                  
                  }),
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
               
                backgroundColor: Colors.black87,
              
                title: const Text('Informação da compra'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
               //         final dynamic tes = streamSnapshot.data!.docs[index];
                        var noteInfo = streamSnapshot.data?.docs[index].data()
                            as Map<String, dynamic>;
                //        var docID = streamSnapshot.data?.docs[index].id;
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
                                  Text("Valor: ${preco.toString()}",
                                      style: const TextStyle(fontSize: 16)),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text("Quantidade: ${quantidade.toString()} ",
                                      style: const TextStyle(fontSize: 16)),
                                
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
                              Text("Forma de Pagamento: ${widget.formaDePagamento}",style: TextStyle(fontSize: 16,  fontWeight: FontWeight.bold),),
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
