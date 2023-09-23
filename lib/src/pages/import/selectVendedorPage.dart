import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/pages/import/carinhoTest.dart';
import 'package:my_app/src/pages/import/vendedoresPage.dart';

class SelecionarVendedor extends StatefulWidget {
  dynamic id;
   SelecionarVendedor({super.key,required this.id});

  @override
  State<SelecionarVendedor> createState() => _SelecionarVendedorState();
}

class _SelecionarVendedorState extends State<SelecionarVendedor> {
 TextEditingController seachtf = TextEditingController();
  final quantidadeController = TextEditingController();

 

  removeQuantidade(dynamic id, dynamic quantiade) {
    CollectionReference teste =
        FirebaseFirestore.instance.collection('vendedores');
    return teste.doc(id).update({"quantidade": quantiade});
  }

  dynamic teste;

  @override
  void initState() {
  
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('vendedores')
        .where(
          'nome',
          isGreaterThanOrEqualTo: seachtf.text,
        )
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                print("BELEZA");
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
              hintText: 'Pesquisar',
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
                var preco = snapshot.data!.docChanges[index].doc['nome'];

                var quantidade =
                    snapshot.data!.docChanges[index].doc['email'];
               
                var docID = snapshot.data!.docs[index].id;
                return Card(
                    child: ListTile(
                  title: Text(snapshot.data!.docChanges[index].doc['nome'],
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
                                title: const Text('Confirmar vendedor?'),
                                content: const Text("Deseja confirmar"),
                                actions: [
                                  MaterialButton(
                                      color: Colors.red,
                                      textColor: Colors.white,
                                      child: const Text('Confirmar'),
                                      onPressed: () {
                                        // seachtf.clear();
                                         Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                CarrinhoPageNew (item: widget.id , vendedor: preco, idVendedor: docID)));

                                        

                                       

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
