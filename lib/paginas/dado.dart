import 'dart:math';
import 'package:flutter/material.dart';

/// Classe que inicializa a função Dado
class DadoPage extends StatefulWidget {
  /// Construtor responsável pela função Dado
  const DadoPage({super.key});

  @override
  State<DadoPage> createState() => _DadoPage();
  }

/// Classe que possui toda a função Dado
class _DadoPage extends State<DadoPage> with SingleTickerProviderStateMixin {
  final Random randomizer = Random();
  int dadoAtual = 1;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

void rolarDado() {
  _controller.forward(from: 0.0).then((_) {
    setState(() {
      dadoAtual = randomizer.nextInt(20) + 1;
      }
    );
    _controller.reset();
    }
  );
}

static const Color appBarColor = Color.fromRGBO(103, 79, 163, 1);

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: appBarColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
          },
        ),
      title: const Text(
        'Rolagem de Dado',
         style: TextStyle(
          color: Color.fromRGBO(246, 237, 240, 1),
          fontSize: 16,
          ),
        ),
      ),
    body: ColoredBox(
      color: const Color.fromARGB(20, 17, 24, 1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RotationTransition(
              turns: _animation,
              child: Image.asset(
                'assets/images/d20-$dadoAtual.png',
                width: 200,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton( onPressed: rolarDado,
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromRGBO(198, 186, 236, 1),
                backgroundColor: const Color.fromRGBO(20, 17, 24, 1),
              ),
              child: const Text('Rolar Dado', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    ),
  );
}

@override
void dispose() {
 _controller.dispose();
 super.dispose();
  }
}
