import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_app/src/database/dao/cliente_dao.dart';
import 'package:my_app/src/database/entities/clienteLocal.dart';
import 'package:my_app/src/pages/import/adm/barsAdmLayout.dart';

import 'clientePage.dart';

class EditPage extends StatefulWidget {
  dynamic cliente;
  dynamic id;
  EditPage({super.key, required this.cliente, required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String? _name;
  String? _telefone;
  final nome = TextEditingController();
  final endereco = TextEditingController();
  final email = TextEditingController();
  final telefone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    nome.text = widget.cliente['nome'];
    endereco.text = widget.cliente['endereco'];
    email.text = widget.cliente['email'];
    telefone.text = widget.cliente['telefone'];
  }

  var maskFormatter = new MaskTextInputFormatter(
      mask: "(##) #####-####",
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87,
      centerTitle: true,
        title: Text("Edição de Cliente")),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Container(
                  height: 150,
                ),
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -40, 0),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          "NOME:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: nome,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "EMAIL:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: email,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "TELEFONE:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                            inputFormatters: [maskFormatter],
                            controller: telefone),
                        SizedBox(height: 10),
                        Text(
                          "ENDEREÇO:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: endereco,
                        ),
                        SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black87,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 70),
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  Database.updateUserData(
                                      widget.id,
                                      nome.text,
                                      telefone.text,
                                      email.text,
                                      endereco.text
                                     );

                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const BarsAdmPage()));
                                  });
                                },
                                child: Text("ALTERAR")),
                          ],
                        ),
                        SizedBox(height: 30),
                        _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.amber),
                              )
                            : SizedBox.shrink()
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
