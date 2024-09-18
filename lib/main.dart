import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tavernadoscombos/firebase_options.dart';
import 'package:tavernadoscombos/paginas/login.dart';
import 'package:tavernadoscombos/services/firebase_service.dart';
void main() {
 init();
 runApp(const MyApp());
}

/// Função responsável por iniciar o Firebase
Future<void> init() async {
    await dotenv.load();
    WidgetsFlutterBinding.ensureInitialized();
    await FirebaseService.instance.initialize();
  }

/// Classe responsável por conter todo o app
class MyApp extends StatelessWidget {
 ///Construtor responsável pelo app
 const MyApp({super.key});

 @override
 Widget build(BuildContext context) {
 return MaterialApp(
 debugShowCheckedModeBanner: false,
 title: 'Taverna dos Combos',
 theme: ThemeData.dark(),
 home: LoginPage(),
 );
 }
}
