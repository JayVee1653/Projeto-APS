import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tavernadoscombos/ficha.dart';

/// Classe responsável por toda a página de Editar Ficha
class EditarFichaPage extends StatefulWidget {
  /// Constructo responsável por toda a página de Editar Ficha
  const EditarFichaPage({super.key, this.ficha});
  /// Chamada responsável por adquirir todo as informações da ficha
  final Ficha? ficha;

  @override
  _EditarFichaPageState createState() => _EditarFichaPageState();
}

class _EditarFichaPageState extends State<EditarFichaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _classeController = TextEditingController();
  final TextEditingController _origemController = TextEditingController();
  final TextEditingController 
  _poderesgeraisController = TextEditingController();
  final TextEditingController _magiasController = TextEditingController();
  List<String> _poderesgerais = <String>[];
  List<String> _magias = <String>[];

  @override
  void initState() {
    super.initState();
    if (widget.ficha != null) {
      _nomeController.text = widget.ficha!.nome;
      _classeController.text = widget.ficha!.classe;
      _origemController.text = widget.ficha!.origem;
      _poderesgerais = widget.ficha!.poderesGerais;
      _magias = widget.ficha!.magias;
    }
  }


  @override
  void dispose() {
    _poderesgeraisController.dispose();
    _magiasController.dispose();
    super.dispose();
  }

  void _adicionarPoderes() {
    setState(() {
      _poderesgerais.add(_poderesgeraisController.text);
      _poderesgeraisController.clear();
    });
  }

  void _adicionarMagias() {
    setState(() {
      _magias.add(_magiasController.text);
      _magiasController.clear();
    });
  }

  void _removerPoderes(int index) {
    setState(() {
      _poderesgerais.removeAt(index);
    });
  }

  void _removerMagias(int index) {
    setState(() {
      _magias.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Ficha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, coloque um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _classeController,
                decoration: const InputDecoration(labelText: 'Classe'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, coloque uma classe';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _origemController,
                decoration: const InputDecoration(labelText: 'Origem'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, coloque uma origem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Poderes Gerais', style: TextStyle(fontSize: 16.0)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _poderesgerais.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_poderesgerais[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removerPoderes(index),
                    ),
                  );
                },
              ),
              TextFormField(
                controller: _poderesgeraisController,
                decoration: const InputDecoration
                (labelText: 'Adicionar Poder Geral'),
              ),
              TextButton(
                onPressed: _adicionarPoderes,
                child: const Text('Adicionar'),
              ),
              const Text('Magia', style: TextStyle(fontSize: 16.0)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _magias.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_magias[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removerMagias(index),
                    ),
                  );
                },
              ),
              TextFormField(
                controller: _magiasController,
                decoration: const InputDecoration(labelText: 'Adicionar Magia'),
              ),
              TextButton(
                onPressed: _adicionarMagias,
                child: const Text('Adicionar'),
              ),
              TextButton(
                child: const Text('Salvar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (FirebaseAuth.instance.currentUser?.uid != null) {
                      final Ficha ficha = Ficha(
                        authorUID: FirebaseAuth.instance.currentUser!.uid,
                        classe: _classeController.text,
                        nome: _nomeController.text,
                        origem: _origemController.text,
                        poderesGerais: _poderesgerais,
                        magias: _magias,
                      );
                      if(widget.ficha != null && widget.ficha!.uID.isNotEmpty) {
                       await FirebaseFirestore.instanceFor(
                              app: Firebase.apps.first,)
                          .collection('fichas')
                          .doc(widget.ficha!.uID)
                          .update(ficha.toMap()); 
                      } else {
                        await FirebaseFirestore.instanceFor(
                              app: Firebase.apps.first,)
                          .collection('fichas')
                          .add(ficha.toMap());
                      }
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
