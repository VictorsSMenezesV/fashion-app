import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/database/dao/produto_dao.dart';
import 'package:my_app/src/database/dao/vendedor_dao.dart';
import 'package:my_app/src/pages/import/cadastroProdutoPage.dart';
import 'package:my_app/src/pages/import/cadastroVendedorPage.dart';
import 'package:my_app/src/pages/import/editProdutoPage.dart';
import 'package:my_app/src/pages/import/editVendedorPage.dart';
import 'package:my_app/src/pages/import/homePage.dart';
import 'package:my_app/src/pages/import/paginaVendaUnica.dart';

class PerfilVendedores extends StatefulWidget {
  const PerfilVendedores({super.key});

  @override
  State<PerfilVendedores> createState() => _PerfilVendedoresState();
}

class _PerfilVendedoresState extends State<PerfilVendedores> {
 List dataList = [];

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CadastroVendedorPage()));
                },
                icon: Icon(Icons.add_circle_outline_outlined ))
          ],
          title: const Text("Página de Vendedores"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: DatabaseEstoque.readItems2(),
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
                  var nome = noteInfo['nome'];
                  var endereco = noteInfo['email'];
                  var endereco2 = noteInfo['telefone'];
                  var id0 = noteInfo['idVendedor'];
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
                        'Nome: $nome',
                        style: TextStyle(fontSize: 25),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'E-mail: ${endereco.toString()}    Telefone: ${endereco2.toString()}',
                        maxLines: 1,
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        width: 200,
                        child: Row(children: [
                        
                          
                          IconButton(
                              onPressed: () {
                              
                                      Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                EditVendedorPage(id: docID,vendedor:noteInfo)));

                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title:
                                              const Text('Excluir Vendedor? '),
                                          content: const Text(
                                              'Deseja excluir esse vendedor?'),
                                          actions: [
                                            MaterialButton(
                                                color: Colors.black87,
                                                textColor: Colors.white,
                                                child: const Text('Sim'),
                                                onPressed: () async {
                                                 await VendedorDatabase
                                                      .deleteItem(
                                                          docID:
                                                              docID.toString());
                                                 
                                                  Navigator.of(context).pop();
                                                }),
                                            MaterialButton(
                                              color: Colors.black87,
                                              textColor: Colors.white,
                                              child: const Text('Não'),
                                              onPressed: () async {
                                                Navigator.of(context).pop();

                                                /**
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const SelectProductPage()));
                               */
                                              },
                                            ),
                                          ],
                                        ));
                              },
                              icon: Icon(Icons.delete))
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
@override
  Widget build(BuildContext context) {
    return const Placeholder();
     }
