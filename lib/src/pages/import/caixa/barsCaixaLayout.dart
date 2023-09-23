import 'package:flutter/material.dart';

class BarsCaixaPage extends StatefulWidget {
  const BarsCaixaPage({super.key});

  @override
  State<BarsCaixaPage> createState() => _BarsCaixaPageState();
}

class _BarsCaixaPageState extends State<BarsCaixaPage> {
   

  String taa  = '';
  
bool saved = false;
  final screens = [

   
    // InicioOS(log: "")
  
    
  ];
  List<List<dynamic>> data = [];
  
  int currentIndex = 0;
  

 
   Future<bool> showExitPopup() async {
    return await showDialog(
            //show confirm dialogueq'
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Sair do Aplicativo'),
              content: const Text('Voçê deseja sair do aplicativo?'),
              actions: [
                MaterialButton(
                  color: Colors.indigo[900],
                  textColor:  Colors.white,
                  onPressed: () => Navigator.of(context).pop(true),
                  //return false when click on "NO"
                  child: const Text('Sim'),
                ),
                MaterialButton(
                  color: Colors.indigo[900],
                  textColor:  Colors.white,
                  onPressed: () => Navigator.of(context).pop(false),
                  //return true when click on "Yes"
                  child: const Text('Não'),
                ),
              ],
            ),
          ) ??
          false; 
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  WillPopScope(
          onWillPop: () async  => false,
          child: Scaffold(
              
                  /*  appBar: AppBar(actions: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                            //  loadAsset();
                           //   load();
                            //  teste();
                            });
                          },
                          icon: const Icon(Icons.add))
                    ]),*/
              body: screens[currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.indigo[900],
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white54,
                type: BottomNavigationBarType.fixed,
                iconSize: 40,
                showUnselectedLabels: false,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.text_snippet_outlined),
                    label: 'O.S',
                    // backgroundColor: Colors.blue,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.pageview_outlined),
                    label: 'Produtos',
                    // backgroundColor: Colors.green,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Pedidos',
                    //backgroundColor: Colors.orange,
                  ),
                   BottomNavigationBarItem(
                    icon: Icon(Icons.account_box),
                    label: 'Clientes',
                    // backgroundColor: Colors.blue,
                  ),
                ],
              )),
        ));
  }
}
