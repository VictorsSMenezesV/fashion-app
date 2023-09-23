import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/pages/import/clientePage.dart';
import 'package:my_app/src/pages/import/estoquePage.dart';
import 'package:my_app/src/pages/import/perfilVendedores.dart';
import 'package:my_app/src/pages/import/vendedoresPage.dart';

class VendedorPageUser extends StatefulWidget {
  const VendedorPageUser({super.key});

  @override
  State<VendedorPageUser> createState() => _VendedorPageUserState();
}

class _VendedorPageUserState extends State<VendedorPageUser> {
    Future<dynamic> addVenda(
      ) async {
    return FirebaseFirestore.instance.collection("vend").doc().set({
      "inicio": DateTime.now().toString(),
      "valorFinal": 0,
      "valido":false
    });
  }

  

 List<String> list = <String>['opa', 'nometeste', 'Three', 'Four'];
 String drop = "opa";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
           ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 75,
                  width: 75,
                ),
                ElevatedButton(
                    onPressed: (() {
                     
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Iniciar venda? '),
                                content:
                                    const Text('Deseja iniciar uma venda?'),
                                actions: [
                                  MaterialButton(
                                      color: Colors.blueAccent,
                                      textColor: Colors.white,
                                      child: const Text('Sim'),
                                      onPressed: () async {

                                        await addVenda();
                                        setState(() {
                                          Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                   VendedorPage()));
                                        });
                                        
                                      }),
                                  MaterialButton(
                                    color: Colors.blueAccent,
                                    textColor: Colors.white,
                                    child: const Text('Não'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                    }),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 150, vertical: 75),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Iniciar Compra")
                      ],
                    )),
              ],
            ),
            Column(
              children: [],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    onPressed: (() {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const EstoquePage()));
                    }),
                    child: Row(
                      children: [
                        Icon(
                          Icons.storage,
                          size: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Estoque")
                      ],
                    )),
                SizedBox(
                  height: 50,
                  width: 50,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    onPressed: (() {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                   VendedorPage()));
                    }),
                    child: Row(
                      children: [
                        Icon(
                          Icons.handshake_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Vendas")
                      ],
                    )),
                    SizedBox(
                  height: 50,
                  width: 50,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    onPressed: (() {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                   PerfilVendedores()));
                    }),
                    child: Row(
                      children: [
                        Icon(
                          Icons.handshake_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Vendedores")
                      ],
                    )),
                SizedBox(
                  height: 50,
                  width: 50,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    onPressed: (() {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ClientePage()));
                    }),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Cliente")
                      ],
                    )),
              ],
            ),
            Column(
              children: [],
            )
          ],
        )),
      ),
    );
  }
}
