import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/database/dao/produto_dao.dart';
import 'package:my_app/src/pages/import/cadastroProdutoPage.dart';
import 'package:my_app/src/pages/import/editProdutoPage.dart';


class EstoquePageEstoquista extends StatefulWidget {
  const EstoquePageEstoquista({super.key});

  @override
  State<EstoquePageEstoquista> createState() => _EstoquePageEstoquistaState();
}

class _EstoquePageEstoquistaState extends State<EstoquePageEstoquista> {
  
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
                              const CadastroProductPage()));
                },
                icon: const Icon(Icons.add_circle_outline_outlined ))
          ],
          title: const Text("Página de Produtos"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: DatabaseEstoque.readItems(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("DEU RUIMMMM");
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: ((context, index) => const SizedBox(
                      height: 16.0,
                    )),
                itemBuilder: (context, index) {
                  var noteInfo =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  var docID = snapshot.data?.docs[index].id;
                  var nome = noteInfo['descricao'];
                  var precoVenda = noteInfo['precoVenda'];
                  var quantidade = noteInfo['quantidade'];
                 
                  var categoria = noteInfo['categoria'];
                  var precoCusto = noteInfo['precoCusto'];
                    var quantidadeMaxima = noteInfo['quantidadeMaxima'];
                      var quantidadeMinima = noteInfo['quantidadeMinima'];

                       Color itemColor = quantidade == quantidadeMinima || quantidade < quantidadeMinima  ?  Colors.yellow : Colors.black12 ;
                  //  print(docID);

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
                        'Descrição: $nome',
                        style: const TextStyle(fontSize: 25),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Preço Venda: ${precoVenda.toString()}    Preço Custo: ${precoCusto.toString()}     Quantidade em Estoque: ${quantidade.toString()}     Quantidade Mínima: ${quantidadeMinima.toString()}     Quantidade Máxima: ${quantidadeMaxima.toString()}     Categoria: ${categoria.toString()}',
                        maxLines: 1,
                        style:const TextStyle(fontSize: 20,  fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            EditProdutoPage(
                                              id: docID,
                                              produto: noteInfo,
                                            )));
                              },
                              icon:const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title:
                                              const Text('Excluir Produto? '),
                                          content: const Text(
                                              'Deseja excluir esse produto?'),
                                          actions: [
                                            MaterialButton(
                                                color: Colors.black87,
                                                textColor: Colors.white,
                                                child: const Text('Sim'),
                                                onPressed: () async {
                                                  await DatabaseEstoque
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
                              icon:const Icon(Icons.delete))
                        ]),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
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
                IconButton(onPressed: () {}, icon:const Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon:const Icon(Icons.delete))
              ]),
            ));
      });
}
