import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/database/dao/cliente_dao.dart';
import 'package:my_app/src/database/entities/venda_unica.dart';
import 'package:my_app/src/database/entities/vendedor.dart';
import 'package:my_app/src/pages/import/cadastroClientePage.dart';
import 'package:my_app/src/pages/import/editClientePage.dart';
import 'package:my_app/src/pages/import/homePage.dart';
import 'package:my_app/src/pages/perfilClientePage.dart';
import 'package:my_app/src/pages/vendasPage.dart';

class PaginaVendaUnica extends StatefulWidget {
  dynamic id;
   PaginaVendaUnica({super.key, required this.id});

  @override
  State<PaginaVendaUnica> createState() => _PaginaVendaUnicaState();
}

class _PaginaVendaUnicaState extends State<PaginaVendaUnica> {
  List<VendaUnica> listListins = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    refresh();
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendas "),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormModal();
        },
        child: const Icon(Icons.add),
      ),
      body: (listListins.isEmpty)
          ? const Center(
              child: Text(
                "Nenhuma lista ainda.\nVamos criar a primeira?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView(
              children: List.generate(
                listListins.length,
                (index) {
                  VendaUnica model = listListins[index];
                  return ListTile(
                    leading: const Icon(Icons.list_alt_rounded),
                    title: Text(model.dataVenda.toString()),
                    subtitle: Text(model.valorTotal.toString()),
                    trailing: Icon(Icons.abc),
                  );
                },
              ),
            ),
    );
  }

  refresh() async {
    List<VendaUnica> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("vendedores").doc(widget.id).collection("vendas").get();

    for (var doc in snapshot.docs) {
      temp.add(VendaUnica.fromMap(doc.data()));
    }

    setState(() {
      listListins = temp;
    });
  }

  showFormModal() {
    // Labels à serem mostradas no Modal
    String labelTitle = "Adicionar Listin";
    String labelConfirmationButton = "Salvar";
    String labelSkipButton = "Cancelar";

    // Controlador do campo que receberá o nome do Listin
    TextEditingController nameController = TextEditingController();

    // Função do Flutter que mostra o modal na tela
    showModalBottomSheet(
      context: context,

      // Define que as bordas verticais serão arredondadas
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(32.0),

          // Formulário com Título, Campo e Botões
          child: ListView(
            children: [
              Text(labelTitle, style: Theme.of(context).textTheme.headline5),
              TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(label: Text("Nome do Listin")),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(labelSkipButton),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Criar um objeto Listin com as infos
                     

                      // Fechar o Modal
                      Navigator.pop(context);
                    },
                    child: Text(labelConfirmationButton),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
