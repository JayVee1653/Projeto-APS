import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tavernadoscombos/paginas/criar_conta.dart';
import 'package:tavernadoscombos/paginas/lista.dart';

class LoginPage extends StatelessWidget {

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Login'),
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
                  controller: loginEmailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "seuemail@gmail.com",
                    label: Text("E-mail"),
                  ),
                ),
                SizedBox(
                  height: 16,
                  ),
                TextField(
                  obscureText: true,
                  controller: loginSenhaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Senha"), 
                  ),
                ),
                SizedBox(
                  height: 16,
                  ),
                TextButton(
                  onPressed: () async {
                    
                    String email = loginEmailController.text;
                    String senha = loginSenhaController.text;
                    var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, 
                      password: senha,
                    );
                    if(user != null){
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ListaPage(),
                      ),
                    );
                    }
                    print(user);
                  },
                child: Text("Login"),
                ),
                SizedBox(
                  height: 16,
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CriarContaPage(),
                      ),
                    );
                  }, 
                  child: Text("Criar uma conta"),
                  ),
              ]
          ),
        ),
      ),
    );
  }
}