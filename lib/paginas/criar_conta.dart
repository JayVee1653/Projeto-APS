import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tavernadoscombos/paginas/lista.dart';

/// Classe que engloba toda a página de Criar Conta
class CriarContaPage extends StatelessWidget {

  /// Controlador responsável pelo e-mail
  final TextEditingController criarEmailController = TextEditingController();
  /// Controlador responsável pela senha
  final TextEditingController criarSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Criar Conta'),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
              children: <Widget>[
                const Text('Bem-vindo a Taverna dos Combos!'),
                const SizedBox(
                    height: 16,
                    ), 
                TextField(
                  controller: criarEmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'seuemail@gmail.com',
                    label: Text('Insira o seu e-mail'),
                  ),
                ),
                const SizedBox(
                    height: 16,
                    ),
                TextField(
                  obscureText: true,
                  controller: criarSenhaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Sua senha deve ter números e caracteres',
                    label: Text('Insira uma senha'), 
                  ),
                ),
                const SizedBox(
                    height: 16,
                    ),
                TextButton(
                  onPressed: () async {
                    final String email = criarEmailController.text;
                    final String senha = criarSenhaController.text;
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, 
                      password: senha,
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: 
                      (BuildContext context) => ListaPage(),
                      ),
                    );
                  },
                  child: const Text('Criar Conta'),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
