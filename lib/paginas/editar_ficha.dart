import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tavernadoscombos/ficha.dart';

class EditarFichaPage extends StatefulWidget {
  final Ficha? ficha;
  EditarFichaPage({Key? key, this.ficha}) : super(key: key);

  @override
  _EditarFichaPageState createState() => _EditarFichaPageState();
}

class _EditarFichaPageState extends State<EditarFichaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _classeController = TextEditingController();
  final _origemController = TextEditingController();
  final _poderesgeraisController = TextEditingController();
  final _magiasController = TextEditingController();
  List<String> _poderesgerais = [];
  List<String> _magias = [];

  @override
  void initState() {
    super.initState();
    if (widget.ficha != null) {
      _nomeController.text = widget.ficha!.Nome;
      _classeController.text = widget.ficha!.Classe;
      _origemController.text = widget.ficha!.Origem;
      _poderesgerais = widget.ficha!.Poderes_gerais;
      _magias = widget.ficha!.Magias;
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
        title: Text('Editar Ficha'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, coloque um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _classeController,
                decoration: InputDecoration(labelText: 'Classe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, coloque uma classe';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _origemController,
                decoration: InputDecoration(labelText: 'Origem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, coloque uma origem';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Poderes Gerais', style: TextStyle(fontSize: 16.0)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _poderesgerais.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_poderesgerais[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removerPoderes(index),
                    ),
                  );
                },
              ),
              TextFormField(
                controller: _poderesgeraisController,
                decoration: InputDecoration(labelText: 'Adicionar Poder Geral'),
              ),
              TextButton(
                child: Text('Adicionar'),
                onPressed: _adicionarPoderes,
              ),
              Text('Magia', style: TextStyle(fontSize: 16.0)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _magias.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_magias[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removerMagias(index),
                    ),
                  );
                },
              ),
              TextFormField(
                controller: _magiasController,
                decoration: InputDecoration(labelText: 'Adicionar Magia'),
              ),
              TextButton(
                child: Text('Adicionar'),
                onPressed: _adicionarMagias,
              ),
              TextButton(
                child: Text('Salvar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (FirebaseAuth.instance.currentUser!.uid != null) {
                      final ficha = Ficha(
                        Author_uid: FirebaseAuth.instance.currentUser!.uid,
                        Classe: _classeController.text,
                        Nome: _nomeController.text,
                        Origem: _origemController.text,
                        Poderes_gerais: _poderesgerais,
                        Magias: _magias,
                      );
                      if(widget.ficha != null && widget.ficha!.Uid.isNotEmpty) {
                       await FirebaseFirestore.instanceFor(
                              app: Firebase.apps.first)
                          .collection('fichas')
                          .doc(widget.ficha!.Uid)
                          .update(ficha.toMap()); 
                      } else {
                        await FirebaseFirestore.instanceFor(
                              app: Firebase.apps.first)
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