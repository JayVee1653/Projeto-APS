import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CriarContaPage extends StatelessWidget {

  TextEditingController criarEmailController = TextEditingController();
  TextEditingController criarSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Criar Conta'),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
              children: [
                Text("Bem-vindo a Taverna dos Combos!"),
                SizedBox(
                    height: 16,
                    ), 
                TextField(
                  controller: criarEmailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "seuemail@gmail.com",
                    label: Text("Insira o seu e-mail"),
                  ),
                ),
                SizedBox(
                    height: 16,
                    ),
                TextField(
                  obscureText: true,
                  controller: criarSenhaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Insira uma senha"), 
                  ),
                ),
                SizedBox(
                    height: 16,
                    ),
                TextButton(
                  onPressed: () async {
                    String email = criarEmailController.text;
                    String senha = criarSenhaController.text;
                    var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, 
                      password: senha,
                    );
                    print(user);
                  },
                  child: Text("Criar Conta"),
                ),
              ]
          ),
        ),
      ),
    );
  }
}