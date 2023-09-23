import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_app/src/database/entities/vendedor.dart';
import 'package:my_app/src/pages/import/adm/barsAdmLayout.dart';
import 'package:uuid/uuid.dart';

class CadastroVendedorPage extends StatefulWidget {
  const CadastroVendedorPage({super.key});

  @override
  State<CadastroVendedorPage> createState() => _CadastroVendedorPageState();
}

class _CadastroVendedorPageState extends State<CadastroVendedorPage> {
    final nome = TextEditingController();
  final email = TextEditingController();
  final telefone = TextEditingController();
   
  var maskFormatter =  MaskTextInputFormatter(
      mask: "(##) #####-####" ,
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87,
      centerTitle: true,
        title: Text("Cadastro de Vendedor"),
      ),
      body: Center(
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
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                Icons.assignment_ind ,
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
                                  color: Colors.black87,
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
                                color: Colors.black87,
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
                              controller: email,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
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
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                Icons.local_phone,
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
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    
                    
                      SizedBox(
                        width: 20,
                        height: 60,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 70),
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                       

                           Vendedor vendedor = Vendedor(
                        id: const Uuid().v1(),
                        nome: nome.text,
                        email: email.text,
                        telefone: telefone.text
                      );
                        

                      // Salvar no Firestore
                      
                    FirebaseFirestore.instance.collection("vendedores")
                          .doc(vendedor.id)
                          .set(vendedor.toMap());
                        

                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const BarsAdmPage()));
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
    );
  }
}
