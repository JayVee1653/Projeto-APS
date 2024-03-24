import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tavernadoscombos/ficha.dart';
import 'package:tavernadoscombos/paginas/editar_ficha.dart';

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

  List<Ficha> fichas = [];

  Widget apagar(Author_uid, uid) {
    if (FirebaseAuth.instance.currentUser != null && Author_uid == FirebaseAuth.instance.currentUser!.uid) {
      return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          db!.collection("fichas").doc(uid).delete();
          setState(() {
            fichas.removeWhere((element) => element.Uid == uid);
          });
        },
      );
    }
    return SizedBox();
  }

    Widget editar(Ficha ficha) {
    if (FirebaseAuth.instance.currentUser != null && 
        ficha.Author_uid == FirebaseAuth.instance.currentUser!.uid) {
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () async {
          await Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => EditarFichaPage(
                ficha: ficha
                )));
        carregarFichas();
        }
      );
    }
    return SizedBox();
  }

  Widget construirLista(BuildContext context, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: ${fichas[index].Nome}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary)),
                Text('Classe: ${fichas[index].Classe}'),
                Text('Origem: ${fichas[index].Origem}'),
                Text('Magias: ${fichas[index].Magias.join(", ")}'),
                Text('Poderes Gerais: ${fichas[index].Poderes_gerais.join(", ")}'),
              ],
            ),
            Spacer(),
            editar(fichas[index]),
            apagar(fichas[index].Author_uid, fichas[index].Uid),
          ],
        ),
      ),
    );
  }

  void carregarFichas() async {
    final response = await db!.collection("fichas").get();
    setState(() {
      fichas.clear();
      for (var element in response.docs) {
        fichas.add(Ficha(
            Uid: element.id,
            Author_uid: element["Author_uid"],
            Classe: element["Classe"],
            Magias: List<String>.from(element["Magias"]),
            Nome: element["Nome"],
            Origem: element["Origem"],
            Poderes_gerais: List<String>.from(element["Poderes_gerais"])));
      }
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditarFichaPage()));
        },
        child: Icon(Icons.add),
        ),
  );
  
}
  
}