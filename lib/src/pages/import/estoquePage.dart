import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:my_app/src/database/dao/produto_dao.dart';
import 'package:my_app/src/pages/import/cadastroProdutoPage.dart';

import 'package:my_app/src/pages/import/editProdutoPage.dart';
import 'package:my_app/src/pages/import/homePage.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  // CollectionReference testeBanco = Firestore.instance.collection("clientes");

  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          automaticallyImplyLeading: false,
         
          title: const Text("Página de Produtos"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: DatabaseEstoque.readItems(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("DEU RUIMMMM");
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
                  var nome = noteInfo['descricao'];
                  var endereco = noteInfo['precoVenda'];
                   var categoria = noteInfo['categoria'];
                  var endereco2 = noteInfo['quantidade'];
                  //  print(docID);

                  return Ink(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      onTap: () {},
                      title: Text(
                        'Descrição: $nome',
                        style: TextStyle(fontSize: 25),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Preço: ${endereco.toString()}    Quantidade em Estoque: ${endereco2.toString()}    Categoria: ${categoria.toString()}',
                        maxLines: 1,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        width: 100,
                        child: const Row(children: [
                         
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
              dataList[index]["descricao"],
            ),
            subtitle: Text(
                ' ${dataList[index]["quantidade"]} - ${dataList[index]["valor"]}'),
            trailing: Container(
              width: 100,
              child: Row(children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete))
              ]),
            ));
      });
}
