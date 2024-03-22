import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tavernadoscombos/firebase_options.dart';
import 'package:tavernadoscombos/paginas/login.dart';

void main() {
  init();
  runApp(const MyApp());
}

void init() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taverna dos Combos',
      theme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}
