import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tavernadoscombos/factories/dado_page_factory.dart';
import 'package:tavernadoscombos/factories/editar_ficha_page_factory.dart';
import 'package:tavernadoscombos/factories/taverneiro_page_factory.dart';
import 'package:tavernadoscombos/ficha.dart';
import 'package:tavernadoscombos/paginas/dado.dart';
import 'package:tavernadoscombos/paginas/editar_ficha.dart';
import 'package:tavernadoscombos/paginas/taverneiro.dart';

/// Classe responsável pela página da Lista
class ListaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListaState();
  }
}


class _ListaState extends State<ListaPage> {
  
  _ListaState() {
    db = FirebaseFirestore.instanceFor(app: Firebase.apps.first);
  }
  late FirebaseFirestore? db;

  List<Ficha> fichas = <Ficha>[];

  Widget apagar(String authorUID, String uid) {
    if (FirebaseAuth.instance.currentUser != null && 
    authorUID == FirebaseAuth.instance.currentUser!.uid) {
      return IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          db!.collection('fichas').doc(uid).delete();
          setState(() {
            fichas.removeWhere((Ficha element) => element.uID == uid);
          });
        },
      );
    }
    return const SizedBox();
  }

    Widget editar(Ficha ficha) {
    if (FirebaseAuth.instance.currentUser != null && 
        ficha.authorUID == FirebaseAuth.instance.currentUser!.uid) {
      return IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          await Navigator.push(
            context, 
             MaterialPageRoute<void>(
              builder: (BuildContext context) => 
              EditarFichaPageFactory().createPage(),),);
        carregarFichas();
        },
      );
    }
    return const SizedBox();
  }

  Widget construirLista(BuildContext context, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Nome: ${fichas[index].nome}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,),),
                Text('Classe: ${fichas[index].classe}'),
                Text('Origem: ${fichas[index].origem}'),
                Text('Magias: ${fichas[index].magias.join(", ")}'),
                Text('Poderes Gerais: ${fichas[index].poderesGerais.join
                (", ")}'),
              ],
            ),
            const Spacer(),
            editar(fichas[index]),
            apagar(fichas[index].authorUID, fichas[index].uID),
          ],
        ),
      ),
    );
  }

    Future<void> carregarFichas() async {
    final QuerySnapshot<Map<String, dynamic>> 
    response = await db!.collection('fichas').get();
    setState(() {
      fichas.clear();
      for (final QueryDocumentSnapshot<Map<String, dynamic>> element 
      in response.docs) {
        fichas.add(Ficha(
            uID: element.id,
            authorUID: element['Author_uid'] as String,
            classe: element['Classe'] as String,
            magias: List<String>.from(element['Magias'] as List<dynamic>),
            nome: element['Nome'] as String,
            origem: element['Origem'] as String,
            poderesGerais: List<String>.from(element['Poderes_gerais'] 
            as List<dynamic>,),),);
      }
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextButton(
            onPressed: carregarFichas, 
            style: TextButton.styleFrom(fixedSize: const Size.fromHeight(75)), 
            child: const Text('Carregar'),),
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
        title: const Text('Lista de Fichas'),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const SizedBox(
          height: 70,
          ),
          FloatingActionButton.small(
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute<void>(builder: 
                (BuildContext context) => 
                EditarFichaPageFactory().createPage(),),);
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.small(           
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(builder: 
              (BuildContext context) => DadoPageFactory().createPage(),),);
            },
            child: const Icon(Icons.casino),
          ),
          FloatingActionButton.small(           
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(builder: 
              (BuildContext context) => 
              TaverneiroPageFactory().createPage(),),);
            },
            child: const Icon(Icons.question_mark),
          ),
    ],
  ),
);
  
}
  
}
