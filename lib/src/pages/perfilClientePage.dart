import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileClient extends StatefulWidget {
  dynamic nome;
  dynamic email;
  dynamic telefone;
  dynamic endereco;

  ProfileClient({
    super.key,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.endereco,
  });

  @override
  State<ProfileClient> createState() => _ProfileClientState();
}

class _ProfileClientState extends State<ProfileClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87,
      centerTitle: true,
        title: Text("Perfil do Cliente")),
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
                Container(
                  height: 150,
                  color: Colors.black54,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                )
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -40, 0),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Text('NOME: ${widget.nome}', style: TextStyle(fontSize: 30)),
                SizedBox(height: 50),
                Text('TELEFONE: ${widget.telefone}',
                    style: TextStyle(fontSize: 30)),
                SizedBox(height: 50),
                Text(
                  'ENDEREÇO: ${widget.endereco}',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 50),
                Text('EMAIL: ${widget.email}', style: TextStyle(fontSize: 30)),
                SizedBox(height: 30),
                SizedBox(height: 30),
              ],
            ),
          )
        ],
      ),
    );
  }
}
