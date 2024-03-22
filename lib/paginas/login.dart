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
      body: Center(
        child: Column(
            children: [
              Text("Bem-vindo a Taverna dos Combos!"), 
              TextField(
                controller: loginEmailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "seuemail@gmail.com",
                  label: Text("E-mail"),
                ),
              ),
              TextField(
                obscureText: true,
                controller: loginSenhaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Senha"), 
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ListaPage(),
                    ),
                  );
                  return;
                  
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
    );
  }
}