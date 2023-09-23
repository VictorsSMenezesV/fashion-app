import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_app/src/database/dao/venda_dao.dart';
import 'package:my_app/src/database/dao/vendedor_dao.dart';
import 'package:my_app/src/pages/import/adm/barsAdmLayout.dart';

class EditVendedorPage extends StatefulWidget {
  dynamic id;
  dynamic vendedor;
   EditVendedorPage({super.key,required this.id,required this.vendedor});

  @override
  State<EditVendedorPage> createState() => _EditVendedorPageState();
}

class _EditVendedorPageState extends State<EditVendedorPage> {
    String? _name;
  String? _telefone;
  final nome = TextEditingController();
  final email = TextEditingController();
  final telefone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    nome.text = widget.vendedor['nome'];
    email.text = widget.vendedor['email'];
    telefone.text = widget.vendedor['telefone'];
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
        title: Text("Edição de Vendedor")),
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
                                onPressed: () async{
                                  VendedorDatabase.updateUserData(
                                      widget.id,
                                      nome.text,
                                      telefone.text,
                                      email.text,
      
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
