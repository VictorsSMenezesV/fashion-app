import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/database/dao/cliente_dao.dart';

import 'package:my_app/src/pages/import/editClientePage.dart';

import 'package:my_app/src/pages/perfilClientePage.dart';

import 'cadastroClientePage.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  List dataList = [];
  dynamic teste;



  Future<void> delete(String procutId) async {}

  Future<dynamic> addVenda(
      dynamic comprador, dynamic telefone, dynamic email) async {
    return FirebaseFirestore.instance.collection("vendas").doc().set({
      "comprador": comprador,
      "telefone": telefone,
      "dataCriacao": DateTime.now().toString(),
      "email": email,
      "valorFinal": 0,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black87,
          centerTitle: true,
          actions: [
            
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CadastroClientePage()));
                },
                icon:const Icon(Icons.add_circle_outline_outlined ))
          ],
          automaticallyImplyLeading: false,
          title: const Text("Página de Clientes"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Database.readItems(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("ERRO");
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: ((context, index) =>const SizedBox(
                      height: 16.0,
                    )),
                itemBuilder: (context, index) {
                  var noteInfo =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  var docID = snapshot.data?.docs[index].id;
                  var nome = noteInfo['nome'];
                  var endereco = noteInfo['endereco'];
                  var email = noteInfo['email'];
                  var telefone = noteInfo['telefone'];
                  

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
                        maxLines: 1,
                        style: const TextStyle(fontSize: 25),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Endereço: $endereco       Telefone: $telefone       E-mail: $email',
                        maxLines: 1,
                        style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                       
                        overflow: TextOverflow.ellipsis,
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
                                            ProfileClient(
                                              email: email,
                                              telefone: telefone,
                                              endereco: endereco,
                                              nome: nome,
                                            )));
                              },
                              icon:const Icon(Icons.account_circle_sharp)),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            EditPage(
                                              id: docID,
                                              cliente: noteInfo,
                                            )));
                              },
                              icon:const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title:
                                              const Text('Excluir cliente? '),
                                          content: const Text(
                                              'Deseja excluir esse cliente?'),
                                          actions: [
                                            MaterialButton(
                                                color: Colors.black87,
                                                textColor: Colors.white,
                                                child: const Text('Sim'),
                                                onPressed: () async {
                                                  await Database.deleteItem(
                                                      docID: docID.toString());
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
              dataList[index]["nome"],
            ),
            subtitle: Text(
                ' ${dataList[index]["telefone"]} - ${dataList[index]["endereco"]}'),
            trailing: Container(
              width: 100,
              child: Row(children: [
                IconButton(
                    onPressed: () {
                      /**
                       FirestoreHelper.delete(teste).then((value) {
                        Navigator.pop(context);
                      }); 

                      */
                    },
                    icon:const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Excluir Cliente'),
                                content:
                                    const Text('Deseja excluir o cliente?'),
                                actions: [
                                  MaterialButton(
                                      color: Colors.black87,
                                      textColor: Colors.white,
                                      child: const Text('Sim'),
                                      onPressed: () {
                                        setState(() {
                                          delete(dataList);
                                        });
                                        Navigator.of(context).pop();
                                      }),
                                  MaterialButton(
                                    color: Colors.indigo[900],
                                    textColor: Colors.white,
                                    child: const Text('Não'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                    },
                    icon:const Icon(Icons.delete))
              ]),
            ));
      });
}
