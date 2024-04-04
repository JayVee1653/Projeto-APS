import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tavernadoscombos/paginas/criar_conta.dart';
import 'package:tavernadoscombos/paginas/lista.dart';

/// Classe que engloba toda a página de Login
class LoginPage extends StatelessWidget {

  /// Controlador responsável pelo e-mail
  final TextEditingController loginEmailController = TextEditingController();
  /// Controlador responsável pela senha
  final TextEditingController loginSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login'),
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
                  controller: loginEmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'seuemail@gmail.com',
                    label: Text('E-mail'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                  ),
                TextField(
                  obscureText: true,
                  controller: loginSenhaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Senha'), 
                  ),
                ),
                const SizedBox(
                  height: 16,
                  ),
                TextButton(
                  onPressed: () async {
                    
                    final String email = loginEmailController.text;
                    final String senha = loginSenhaController.text;
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, 
                      password: senha,
                    );
                    Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: 
                    (BuildContext context) => ListaPage(),
                    ),
                  );
                  },
                child: const Text('Login'),
                ),
                const SizedBox(
                  height: 16,
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: 
                      (BuildContext context) => CriarContaPage(),
                      ),
                    );
                  }, 
                  child: const Text('Criar uma conta'),
                  ),
              ],
          ),
        ),
      ),
    );
  }
}
