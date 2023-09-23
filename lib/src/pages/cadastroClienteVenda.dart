import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_app/src/database/dao/cliente_dao.dart';
import 'package:my_app/src/pages/vendasPage.dart';

class CadastroClienteVendaPage extends StatefulWidget {
  const CadastroClienteVendaPage({super.key});

  @override
  State<CadastroClienteVendaPage> createState() =>
      _CadastroClienteVendaPageState();
}

class _CadastroClienteVendaPageState extends State<CadastroClienteVendaPage> {
  final nome = TextEditingController();
  final telefone = TextEditingController();
  final email = TextEditingController();
  final endereco = TextEditingController();
  final municipio = TextEditingController();
  final estado = TextEditingController();

  Future<dynamic> addVenda(
      String? comprador, String? telefone, String? email) async {
    return FirebaseFirestore.instance.collection("vendas").doc().set({
      "comprador": comprador,
      "telefone": telefone,
      "dataCriacao": DateTime.now().toString(),
      "email": email,
      "valorFinal": 0,
    });
  }

  var maskFormatter = new MaskTextInputFormatter(
      mask: "(##) #####-####",
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adiconar Cliente"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/fundo.png"), fit: BoxFit.cover)),
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 25,
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
            Expanded(
              child: Container(
                width: 1800,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: nome,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'NOME',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                inputFormatters: [maskFormatter],
                                controller: telefone,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'TELEFONE',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: endereco,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'ENDEREÇO',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 20,
                          height: 60,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 150, vertical: 75),
                              textStyle: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            await addVenda(
                                nome.text, telefone.text, email.text);
                            await Database.addItem(
                              nome: nome.text,
                              endereco: endereco.text,
                              telefone: telefone.text,
                              email: email.text,
                            );
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const VendasPage()));
                            });
                          },
                          child: const Text("CADASTRAR"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
