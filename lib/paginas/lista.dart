import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListaState();
  }
}


class _ListaState extends State<ListaPage> {
  late FirebaseFirestore? db;
  
  _ListaState() {
    db = FirebaseFirestore.instanceFor(app: Firebase.apps.first);
  }

  List<String> fichas = [];

  Widget construirLista(BuildContext context, int index) {
    return Text(fichas[index]);
  }

  void carregarFichas() async {
    final response = await db!.collection("fichas").get();
    setState(() {
      fichas = response.docs.map((e) => e['Nome'].toString()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: carregarFichas, child: Text("Carregar")),
          Expanded(
            child: ListView.builder(
              itemCount: fichas.length, 
              itemBuilder: construirLista,
              ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Lista de Fichas"),
      ),
  );
  
}
  
}