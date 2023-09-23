import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/database/entities/produto_local.dart';
import 'package:my_app/src/pages/import/adm/visualizarDoc.dart';

import 'package:my_app/src/pages/import/perfilVenda.dart';
import 'package:my_app/src/pages/selectProductPage.dart';

class AdmVendasPage extends StatefulWidget {
  const AdmVendasPage({super.key});

  @override
  State<AdmVendasPage> createState() => _AdmVendasPageState();
}

class _AdmVendasPageState extends State<AdmVendasPage> {
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

  Future<dynamic> addVenda(
      ) async {
    return FirebaseFirestore.instance.collection("vend").doc().set({
      "inicio": DateTime.now().toString(),
      "valorFinal": 0,
      "valido":false
    });
  }
  

  List<Produto> listListins =[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {

                   showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text("Iniciar venda"),
                                            content: Text(
                                                "Deseja iniciar uma venda?"),
                                            actions: [
                                              MaterialButton(
                                                  color: Colors.black87,
                                                  textColor: Colors.white,
                                                  child: const Text('Sim'),
                                                  onPressed: (() {
                                                    setState(() {
                  addVenda();
               });
                                                    Navigator.of(context).pop();
                                                  })),
                                                  MaterialButton(
                                                  color: Colors.black87,
                                                  textColor: Colors.white,
                                                  child: const Text('Não'),
                                                  onPressed: (() {
                                                    Navigator.of(context).pop();
                                                  }))
                                            ],
                                          ));
              
                },
                icon: Icon(Icons.add_circle_outline_outlined ))
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
                  var valorFinal = noteInfo['valorFinal'];
                  var dataInicio = noteInfo['inicio'];
                  var itens = noteInfo['itens'];
                   
                  var formaPageamento = noteInfo['formaPageamento'];
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
                        'Valor Total: $valorFinal ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                      ),
                      subtitle: Text(
                        'Data do início da venda: $dataInicio ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: Container(
                        width: 200,
                        child: Row(children: [
                          IconButton(
                              onPressed: () {
                                print(valido);
                                 if (valido == true) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text("Alerta!"),
                                            content: Text(
                                                "Essa venda já foi finalizada!"),
                                            actions: [
                                              MaterialButton(
                                                  color: Colors.black87,
                                                  textColor: Colors.white,
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
                          builder: (BuildContext context) => SelectProductPage(
                                item: docID, vendedor: '', idVendedor: '',
                              )));
                                }
                                
                              },
                              icon: Icon(Icons.shopping_cart)),
                          IconButton(
                              onPressed: () {
                                
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PerfilVenda(item:docID ,formaDePagamento: formaPageamento,
                                               
                                              )));
                                

                                // Database.deleteItem(docID: docID.toString());
                              },
                              icon: Icon(Icons.dock)),
                               IconButton(
                              onPressed: ()async {
                               
                                 await refresh(docID);
                                
                                setState(() {
                                   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              VizualizarDoc(formaDePagamento: formaPageamento,quantidadeTotal: itens ,valorTotal: valorFinal,itensVendas:listListins ,
                                               
                                              )));
                                });
                                
                                 
                                

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

refresh(dynamic id) async {
    List<Produto> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("vend").doc(id).collection("itens").get();

    for (var doc in snapshot.docs) {
      temp.add(Produto.fromMap(doc.data()));
    }

    setState(() {
      listListins = temp;
    });
  }
 
}