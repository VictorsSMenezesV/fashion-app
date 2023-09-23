 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/database/entities/produto_local.dart';
import 'package:my_app/src/pages/import/selectVendedorPage.dart';
import 'package:my_app/src/pages/import/testProduct.dart';
import 'package:my_app/src/pages/import/vendedoresPage.dart';

class CarrinhoPageNew extends StatefulWidget {
  dynamic item;
  dynamic vendedor;
  dynamic idVendedor;
   CarrinhoPageNew({super.key,required this.item,required this.vendedor,required this.idVendedor});

  @override
  State<CarrinhoPageNew> createState() => _CarrinhoPageNewState();
}

class _CarrinhoPageNewState extends State<CarrinhoPageNew> {
  List<Produto> listListins = [];
  TextEditingController seachtf = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  dynamic total;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  addtoCart(String id, String nome, double valor, double quantidade) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("vend");
    collectionRef
        .doc(id)
        .collection("itens")
        .doc()
        .set({"descricao": nome, "valor": valor, "quantidade": quantidade})
        .whenComplete(() => print("Inserido"))
        .catchError((e) => print(e));
  }
  

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('prods')
        .where(
          'descricao',
          isGreaterThanOrEqualTo: seachtf.text,
        )
        .snapshots();
    return Scaffold(
      appBar:AppBar(
         actions: [
          IconButton(
              onPressed: () async {
                if(widget.vendedor == "Nenhum"){
                  showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Incluir vendedor? '),
                                content:
                                    const Text('Deseja incluir um vendedor a compra?'),
                                actions: [
                                  MaterialButton(
                                      color: Colors.red,
                                      textColor: Colors.black,
                                      child: const Text('Sim'),
                                      onPressed: () async {

                                          Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                 SelecionarVendedor(id: widget.item,)));
                                        
                                      }),
                                  MaterialButton(
                                    color: Colors.red,
                                    textColor: Colors.black,
                                    child: const Text('Não'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                }else{
                  showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Concluir Venda?'),
                                content:
                                    const Text("CONCLUIR?"),
                                actions: [
                                  MaterialButton(
                                      color: Colors.red,
                                      textColor: Colors.black,
                                      child: const Text('Sim'),
                                      onPressed: () async {

                                        
                                         await addVenda(widget.idVendedor);
                                         await addVenda2(widget.item);

                                         setState(() {
                                           Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                   VendedorPage()));
                                         });
                                        
                                        
                                      }),
                                  MaterialButton(
                                    color: Colors.red,
                                    textColor: Colors.black,
                                    child: const Text('Não'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));

                }
              },
              icon: const Icon(Icons.local_grocery_store_rounded)),
              
        ],
        title: const Text("Carrinho"),
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                 SelectProduct(item: widget.item,)));
                                                                
        },
        child: const Icon(Icons.add),
      ),
      body: (listListins.isEmpty)
          ? const Center(
              child: Text(
                "Nenhum item no carrinho.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
                children: [
                  
                  Expanded(
                    child: ListView(
                      children: List.generate(
                        listListins.length, (index) {
                           Produto model = listListins[index];
                          return ListTile(
                            leading: const Icon(Icons.list_alt_rounded),
                            title: Text(model.descricao),
                            subtitle: Text("${model.precoVenda}   - ${model.quantidade} " ),
                          );
                        }),
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
                                 '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 190),
                              Text(''),
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
  }
  
  Future<void> delete(dynamic id1, dynamic id2) async {
    await FirebaseFirestore.instance
        .collection('vend')
        .doc(id1)
        .collection("itens")
        .doc(id2)
        .delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Apagado com sucesso")));
  }

  Widget setupAlertDialoadContainer() {
  return Container(
    height: 300.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: 
    ListView(
                      children: List.generate(
                        listListins.length, (index) {
                           Produto model = listListins[index];
                          return ListTile(
                            leading: const Icon(Icons.list_alt_rounded),
                            title: Text(model.descricao),
                            subtitle: Text("${model}   - ${model.quantidade} " ),
                          );
                        }),
                    ),
  );
}



  showFormModal()async {
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
                    

                      // Salvar no Firestore
                      

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
   refresh() async {
    List<Produto> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("vend").doc(widget.item).collection("itens").get();

    for (var doc in snapshot.docs) {
      temp.add(Produto.fromMap(doc.data()));
    }

    setState(() {
      listListins = temp;
    });
  }
 addVenda(dynamic id
      ) async {

  await FirebaseFirestore.instance.collection("vendedores").doc(id).collection("vendas").doc().set({
      "dataVenda": DateTime.now().toString(),
      "desconto": 50,
      "itens":false,
      "valorBonus":20,
      "valorTotal":200,
     
      

    });
  }

  addVenda2(dynamic id
      ) async {
   await FirebaseFirestore.instance.collection("vend").doc(id).update({
      "dataFinalizada":  DateTime.now().toString(),
      "valido": true,
      "valorFinal": 100,
      "desconto":15,
      "itens":10,
      "vendedor": "teste",
      "formaPagemento": "Dinheiro"
    });
  }
}


/**
 * 
 AppBar(
         actions: [
          IconButton(
              onPressed: () async {
                if(widget.vendedor == "Nenhum"){
                  showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Incluir vendedor? '),
                                content:
                                    const Text('Deseja incluir um vendedor a compra?'),
                                actions: [
                                  MaterialButton(
                                      color: Colors.red,
                                      textColor: Colors.black,
                                      child: const Text('Sim'),
                                      onPressed: () async {

                                          Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                 SelecionarVendedor(id: widget.item,)));
                                        
                                      }),
                                  MaterialButton(
                                    color: Colors.red,
                                    textColor: Colors.black,
                                    child: const Text('Não'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                }else{
                  showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Concluir Venda?'),
                                content:
                                    const Text("CONCLUIR?"),
                                actions: [
                                  MaterialButton(
                                      color: Colors.red,
                                      textColor: Colors.black,
                                      child: const Text('Sim'),
                                      onPressed: () async {

                                        
                                         await addVenda(widget.idVendedor);
                                         await addVenda2(widget.item);

                                         setState(() {
                                           Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                   VendedorPage()));
                                         });
                                        
                                        
                                      }),
                                  MaterialButton(
                                    color: Colors.red,
                                    textColor: Colors.black,
                                    child: const Text('Não'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));

                }
              },
              icon: const Icon(Icons.local_grocery_store_rounded)),
              
        ],
        title: const Text("Listin - Feira Colaborativa"),
      ) 
 
 */