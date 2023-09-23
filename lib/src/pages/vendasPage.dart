import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/database/dao/venda_dao.dart';
import 'package:my_app/src/pages/import/caixaPage.dart';
import 'package:my_app/src/pages/import/homePage.dart';
import 'package:my_app/src/pages/perfilVendasPage.dart';
import 'package:my_app/src/pages/selectProductPage.dart';
import 'package:my_app/src/pages/import/testProduct.dart';

class VendasPage extends StatefulWidget {
  const VendasPage({super.key});

  @override
  State<VendasPage> createState() => _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  List dataList = [];

  Future<QuerySnapshot<Map<String, dynamic>>> getDocid() async {
    final tes = await FirebaseFirestore.instance
        .collection('vendas')
        .orderBy("dataCriacao", descending: true)
        .get();

    return tes;
  }

  Future<QuerySnapshot> buscar2() {
    return FirebaseFirestore.instance
        .collection('vendas')
        .orderBy("DataCriacao", descending: true)
        .get();
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
          title: const Text("Página "),
        ),
        body: FutureBuilder(
          future: getDocid(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("ERRO");
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
                  var nome = noteInfo['comprador'];
                  var telefone = noteInfo['telefone'];
                  var valorFinal = noteInfo['valorFinal'];

                  return Ink(
                    decoration: BoxDecoration(
                      color: Colors.red[300],
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
                                        builder: (BuildContext context) =>
                                            SelectProduct(
                                              item: docID,
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
                                              PerfilVendaPage(
                                                item: docID,
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

  Widget buildItems(dataList) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dataList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text(
              dataList[index]["comprador"],
            ),
            subtitle: Text(
                ' ${dataList[index]["dataCriacao"]} - ${dataList[index]["telefone"]}'),
            trailing: Container(
              width: 200,
              child: Row(children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {}, icon: Icon(Icons.card_giftcard))
              ]),
            ));
      });
}
