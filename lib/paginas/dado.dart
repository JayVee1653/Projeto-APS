import 'dart:math';
import 'package:flutter/material.dart';

/// Classe responsável pela página do Dado
class DadoPage extends StatefulWidget {
  ///Const responsável pela página do Dado
  const DadoPage({super.key});

  @override
  State<DadoPage> createState() => _DadoPage();
}


class _DadoPage extends State<DadoPage> {
  final Random randomizer = Random();
  int dadoAtual = 1;

  void rolarDado() {
    setState(() {
      dadoAtual = randomizer.nextInt(20) + 1;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Rolagem de Dado'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
          'assets/images/d20-$dadoAtual.png',
            width: 200,
          ),
        const SizedBox(height: 20),
        TextButton(
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 28,
              ),),
          onPressed: rolarDado,
          child: const Text('Roll Dice'),
        ),
      ],
    ),
    );
  }
}
