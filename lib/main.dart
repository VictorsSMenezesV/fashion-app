import 'package:flutter/material.dart';
import 'package:my_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/src/pages/import/cadastroProdutoPage.dart';
import 'package:my_app/src/pages/import/caixaPage.dart';
import 'package:my_app/src/pages/import/caixaPageUser.dart';

import 'package:my_app/src/pages/import/loginTeste.dart';
import 'package:my_app/src/pages/import/selectVendedorPage.dart';


const apiKey = "AIzaSyDBUOKUZzcNrPY-GoR9eyVAkWCPS64r80c";
const projectId = "server-mecanica";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool kIsWeb = const bool.fromEnvironment('dart.library.js_util');
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:    const LoginPage2());
  }
}
