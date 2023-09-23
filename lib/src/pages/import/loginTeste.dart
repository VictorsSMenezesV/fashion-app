import 'package:flutter/material.dart';

import 'package:my_app/src/pages/import/adm/barsAdmLayout.dart';

import 'package:my_app/src/pages/import/vendedor/barsVendedorLayout.dart';


class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();

  String user = "adm";
  String senha = "adm2023";
  String user2 = "vendedor";
  String senha2 = "venda2023";
  

  void formatNickname() {
    usuarioController.text = usuarioController.text.replaceAll(" ", "");
    senhaController.text = senhaController.text.replaceAll(" ", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: Center(
        child: Column(children: [
         const SizedBox(
            height: 20,
            width: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        const  SizedBox(
            height: 400,
            width: 500,
          
          ),
          Expanded(
            child: Container(
              height: 1000,
              width: 1000,
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "BEM-VINDO(A)",
                        style: TextStyle(fontSize: 50),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Center(
                              child: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                         const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: usuarioController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'USUÁRIO',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                     const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12)),
                            child:const Center(
                              child: Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        const  SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              obscureText: true,
                              controller: senhaController,
                              decoration:const InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'SENHA',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                     const SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 25),
                            textStyle: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          formatNickname();

                         if(usuarioController.text == user && senhaController.text == senha){
                           Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const BarsAdmPage()));
                         }else if(usuarioController.text == user2 && senhaController.text == senha2){
                           Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const BarsVendedorPage()));
                         } else {
                            ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                                content: Text("Usuário ou senha incorreto")));
                          } 
                        },
                        child: const Text("LOGAR"),
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
