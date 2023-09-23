import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/pages/import/carinhoTest.dart';
import 'package:my_app/src/pages/import/homePage.dart';
import 'package:my_app/src/pages/import/testeCarito.dart';
import 'package:my_app/src/pages/import/perfilVenda.dart';

import 'package:my_app/src/pages/import/testProduct.dart';

class VendedorPage extends StatefulWidget {
 
   VendedorPage({super.key});

  @override
  State<VendedorPage> createState() => _VendedorPageState();
}

class _VendedorPageState extends State<VendedorPage> {
   List dataList = [];

  Future<QuerySnapshot<Map<String, dynamic>>> getDocid() async {
    final tes = await FirebaseFirestore.instance
        .collection('vend')
        .get();

    return tes;
  }

  Future<QuerySnapshot> buscar2() {
    return FirebaseFirestore.instance
        .collection('vend')
        .orderBy("inicio", descending: true)
        .get();  // .orderBy("DataCriacao", descending: true)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const HomePage()));
                },
                icon: Icon(Icons.home))
          ],
          title: const Text("Página de Vendas"),
        ),
        body: FutureBuilder(
          future: buscar2(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("ERROR");
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: ((context, index) => SizedBox(
                      height: 16.0,
                    )),
                itemBuilder: (context, index) {
                  var noteInfo =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  var docID = snapshot.data?.docs[index].id;
                  var nome = noteInfo['vendedor'];
                  var telefone = noteInfo['valorFinal'];
                   var formaPageamento = noteInfo['formaPageamento'];
                  var valorFinal = noteInfo['inicio'];
                   var valido = noteInfo['valido'];
                    Color itemColor = valido == true ?  Colors.green : Colors.red ;

                  return Ink(
                    decoration: BoxDecoration(
                      color: itemColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      onTap: () {},
                      title: Text(
                        'Comprador: $nome   -   Telefone: $telefone',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                      ),
                      subtitle: Text(
                        'Valor Total: $valorFinal ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: Container(
                        width: 200,
                        child: Row(children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CardPage3(
                                item: docID.toString(), vendedor: null, idVendedor: null,
                              )));
                              },
                              icon: Icon(Icons.shopping_cart)),
                          IconButton(
                              onPressed: () {
                                if (valorFinal == 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text("Alerta"),
                                            content: Text(
                                                "Essa venda não contem nenhum item"),
                                            actions: [
                                              MaterialButton(
                                                  color: Colors.red,
                                                  textColor: Colors.black,
                                                  child: const Text('OK'),
                                                  onPressed: (() {
                                                    Navigator.of(context).pop();
                                                  }))
                                            ],
                                          ));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PerfilVenda(item:docID ,formaDePagamento: formaPageamento,
                                               
                                              )));
                                }

                                // Database.deleteItem(docID: docID.toString());
                              },
                              icon: Icon(Icons.document_scanner)),
                        ]),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

 
}
