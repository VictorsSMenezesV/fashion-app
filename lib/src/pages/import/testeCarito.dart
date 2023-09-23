

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/database/dao/produto_dao.dart';
import 'package:my_app/src/database/entities/item_local.dart';
import 'package:my_app/src/database/entities/produto_local.dart';
import 'package:my_app/src/pages/import/adm/barsAdmLayout.dart';
import 'package:my_app/src/pages/import/selectVendedorPage.dart';
import 'package:my_app/src/pages/import/testProduct.dart';
import 'package:my_app/src/pages/import/testeFiscal.dart';
import 'package:my_app/src/pages/import/vendedoresPage.dart';
import 'package:uuid/uuid.dart';

class CardPage3 extends StatefulWidget {
  dynamic item;
  dynamic vendedor;
  dynamic idVendedor;
   CardPage3({super.key,required this.item,required this.vendedor,required this.idVendedor});

  @override
  State<CardPage3> createState() => _CardPage3State();
}

class _CardPage3State extends State<CardPage3> {
 List<ItemLocal> listListins = [];
 List<Produto> listListins2 = [];
 List<Produto> teste = [];
  List<Produto> teste2 = [];
  TextEditingController seachtf = TextEditingController();
    TextEditingController formaDePagamento = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  dynamic totalFinal;
  dynamic totalQuantidade;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
 
  @override
  void initState() {

    teste = listListins2;
    refresh();
    refresh2();
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

   Future<void> delete(String id1, String id2) async {
    await FirebaseFirestore.instance
        .collection('vend')
        .doc(id1)
        .collection("itens")
        .doc(id2)
        .delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Apagado com sucesso")));
  }

  String name = "";
  

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
        backgroundColor: Colors.black12,
        automaticallyImplyLeading: false,
         actions: [
          IconButton(
              onPressed: () async {
              
                 showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Forma de Pagamento'),
                                content: TextField(
                                  decoration: const InputDecoration(
                                      labelText: 'Escreva a forma de pagamento dessa compra'),
                                  keyboardType: TextInputType.number,
                                  controller: formaDePagamento,
                                ),
                                actions: [
                                  MaterialButton(
                                      color: Colors.black87,
                                      textColor: Colors.white,
                                      child: const Text('Confirmar'),
                                      onPressed: () async{
                                        // seachtf.clear();

                                   showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Concluir Venda?'),
                                content:
                                    const Text("Você deseja concluir essa venda?"),
                                actions: [
                                  MaterialButton(
                                      color: Colors.black87,
                                      textColor: Colors.white,
                                      child: const Text('Sim'),
                                      onPressed: () async {

                                      
                                         await addVenda2(widget.item,totalFinal,totalQuantidade,formaDePagamento.text);

                                         setState(() {
                                           Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                    FiscalPage(valorTotal: totalFinal,quantidadeTotal: totalQuantidade, formaDePagamento: formaDePagamento.text, itensVendas: listListins)));
                                         });
                                        
                                        
                                      }),
                                  MaterialButton(
                                    color: Colors.black87,
                                    textColor: Colors.white,
                                    child: const Text('Não'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                                      
                                     

                                        

                                        // bye(lista[index].id as dynamic);
                                      }),
                                  MaterialButton(
                                    color: Colors.black87,
                                    textColor: Colors.white,
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
               
                  

                }
              ,
              icon: const Icon(Icons.check)),
              
        ],
        title:(listListins.isEmpty)
          ? const Center(
              child: Text(
                "Nenhum item no carrinho.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ) : Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Pesquisar...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        )
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
                    child: Container(color: Colors.black12,
                      child: ListView(
                        shrinkWrap:  true,
                        children: List.generate(
                          listListins2.length, (index) {
                             Produto model2 = listListins2[index];
                            if(name.isEmpty){
                             return ListTile(
                                      title: Text(model2.descricao,
                        style: TextStyle(fontSize: 25)),
                                      subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Preço: ${model2.precoVenda.toString()}',
                            style: TextStyle(fontSize: 20)),
                        Text(
                          'Quantidade: ${model2.quantidade.toString()}',
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
                      color: Colors.black87,
                      textColor: Colors.white,
                      child: const Text('Adicionar'),
                      onPressed: () {
                       
                        seachtf.clear();
                    
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Quantidade'),
                                  content: TextField(
                                    decoration: const InputDecoration(
                                        labelText: 'Quantidade'),
                                    keyboardType: TextInputType.number,
                                    controller: quantidadeController,
                                  ),
                                  actions: [
                                    MaterialButton(
                                        color: Colors.black,
                                        textColor: Colors.white,
                                        child: const Text('Confirmar'),
                                        onPressed: () async{
                                          // seachtf.clear();
                                           dynamic teste = model2.quantidade - double.parse(quantidadeController.text);
                                         ItemLocal itemLocal = ItemLocal(
                        id: const Uuid().v1(),
                       descricao: model2.descricao.toString(),
                       valor: model2.precoVenda,
                       quantidade: double.parse(quantidadeController.text)
                       ,idProd: model2.id,
                       quantidadeMomento: model2.quantidade
                      );
                        

                      // Salvar no Firestore
                      
                    FirebaseFirestore.instance.collection("vend")
                          .doc(widget.item).collection("itens").doc(itemLocal.id)
                          .set(itemLocal.toMap());
                                        try{
                                        
                                          DatabaseEstoque.updateEstoque(model2.id,teste);
                                        }catch(e){
                                          print(e);
                                        }
                                        
                                       
                                       refresh();
                                       refresh();
                                        
                                        setState(() {
                                          Navigator.of(context).pop();
                                          
                                        });
                    
                                          quantidadeController.clear();
                    
                                          // bye(lista[index].id as dynamic);
                                        }),
                                    MaterialButton(
                                      color: Colors.black87,
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
                                    );
                            }  if(model2.descricao
                            .toString()
                            .toLowerCase()
                            .startsWith(name.toLowerCase())){
                               return ListTile(
                                      title: Text(model2.descricao,
                        style: TextStyle(fontSize: 25)),
                                      subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Preço: ${model2.precoVenda.toString()}',
                            style: TextStyle(fontSize: 20)),
                        Text(
                          'Quantidade: ${model2.quantidade.toString()}',
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
                      color: Colors.black87,
                      textColor: Colors.white,
                      child: const Text('Adicionar'),
                      onPressed: () {
                       
                        seachtf.clear();
                    
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Quantidade'),
                                  content: TextField(
                                    decoration: const InputDecoration(
                                        labelText: 'Quantidade'),
                                    keyboardType: TextInputType.number,
                                    controller: quantidadeController,
                                  ),
                                  actions: [
                                    MaterialButton(
                                        color: Colors.black87,
                                        textColor: Colors.white,
                                        child: const Text('Confirmar'),
                                        onPressed: () async{
                                         dynamic teste = model2.quantidade - double.parse(quantidadeController.text);
                                       ItemLocal itemLocal = ItemLocal(
                        id: const Uuid().v1(),
                       descricao: model2.descricao.toString(),
                       valor: model2.precoVenda,
                       quantidade: double.parse(quantidadeController.text)
                       ,idProd: model2.id,
                       quantidadeMomento: model2.quantidade
                      );
                        

                      // Salvar no Firestore
                      
                    FirebaseFirestore.instance.collection("vend")
                          .doc(widget.item).collection("itens").doc(itemLocal.id)
                          .set(itemLocal.toMap());

                                        try{
                                          
                                           DatabaseEstoque.updateEstoque(model2.id,teste);
                                        }catch(e){
                                          print(e);
                                        }  // seachtf.clear();
                    
                                      
                                       refresh();
                                       refresh2();
                                        
                                        setState(() {
                                          Navigator.of(context).pop();
                                          
                                        });
                    
                                          quantidadeController.clear();
                    
                                          // bye(lista[index].id as dynamic);
                                        }),
                                    MaterialButton(
                                      color: Colors.black87,
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
                                    );
                            }else{
                              return Container();
                            }
                          }),
                      ),
                    ),
                    
                  ),
                  Container(color: Colors.black87,
                    child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("   --------------- "),Text("Descrição",style: TextStyle(fontSize: 20,color: Colors.white),),Text("Quantidade",style: TextStyle(fontSize: 20,color: Colors.white)),Text("Valor  ",style: TextStyle(fontSize: 20,color: Colors.white))],),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap:  true,  
                      children: List.generate(
                        listListins.length, (index) {
                           ItemLocal model = listListins[index];
                          return ListTile(
                            
                            title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [ Text(" "),Text(model.descricao,style: TextStyle(fontSize: 20)),Text(model.quantidade.toString(),style: TextStyle(fontSize: 20)),Text(model.valor.toString(),style: TextStyle(fontSize: 20))])  ,//Text(model.descricao),
                            leading: IconButton(
                                              color: Colors.red,
                                              iconSize: 35,
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: const Text(
                                                              'Excluir Item'),
                                                          content: const Text(
                                                              'Deseja excluir o item do carrinho?'),
                                                          actions: [
                                                            MaterialButton(
                                                                color:
                                                                    Colors.black87,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    const Text(
                                                                        'Sim'),
                                                                onPressed:
                                                                    ()  async{
                                                                 
                                                              await  delete(widget.item.toString(), model.id.toString());
                                                              try{
                                                                   DatabaseEstoque.updateEstoque(model.idProd,model.quantidadeMomento);

                                                              }catch(e){
                                                                print(e);
                                                              }
                                                              
                                                                refresh();
                                                                  setState(() {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  });
                                                                }),
                                                            MaterialButton(
                                                              color: Colors.black87,
                                                              textColor:
                                                                  Colors.white,
                                                              child: const Text(
                                                                  'Não'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                            context)
                                                                        .pop();
                                                              },
                                                            ),
                                                          ],
                                                        ));
                                              },
                                              icon: const Icon(Icons.delete)),
                          );
                        }),
                    ),
                    
                  )
                 
                  
                 ,
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
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(children: [Text(
                                  'Total: ${totalFinal = listListins.map((product) => product.valor * product.quantidade).toList().reduce((value, element) => value + element).toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),],),
                                      Column(children: [Text(
                                  'Quantidade de itens: ${totalQuantidade = listListins.isNotEmpty ? listListins.map<int>((e) => e.quantidade as dynamic).reduce((value, element) => value + element).toStringAsFixed(0) : 0}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),],),
                                         Column(children: [Text(
                                  ' ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),],)
                              
                               
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
  
 


filterItem(String itemName){
  List<Produto> result = [];
  if(itemName.trim().isEmpty){
  result  = listListins2;
  }else{
    result =listListins2.where((element) => element.toString().toLowerCase().contains(itemName.toLowerCase())).toList();
  }
  setState(() {
    teste = result;
  });
}


  
   refresh() async {
    List<ItemLocal> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("vend").doc(widget.item).collection("itens").get();

    for (var doc in snapshot.docs) {
      temp.add(ItemLocal.fromMap(doc.data()));
    }

    setState(() {
      listListins = temp;
    });
  }
  refresh2() async {
    List<Produto> temp2 = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('prods')
        .where(
          'descricao',
          isGreaterThanOrEqualTo: seachtf.text,
        )
        .get();
        final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('prods')
        .where(
          'descricao',
          isGreaterThanOrEqualTo: seachtf.text,
        )
        .snapshots();

    for (var doc in snapshot.docs) {
      temp2.add(Produto.fromMap(doc.data()));
    }

    setState(() {
      listListins2 = temp2;
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

  addVenda2(dynamic id,dynamic valorFinal,dynamic itens,dynamic formaDePagamento
      ) async {
   await FirebaseFirestore.instance.collection("vend").doc(id).update({
      "dataFinalizada":  DateTime.now().toString(),
      "valido": true,
      "valorFinal": valorFinal,
      "desconto":0,
      "itens":itens,
      "formaPageamento": formaDePagamento
    });
  }
}