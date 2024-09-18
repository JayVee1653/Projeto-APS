import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tavernadoscombos/ficha.dart';

/// Interface Command representando uma ação executável
abstract class Command {
  void execute();
}

/// Command para adicionar um poder
class AdicionarPoderCommand implements Command {
  AdicionarPoderCommand(this.poderesGerais, this.controller);
  final List<String> poderesGerais;
  final TextEditingController controller;

  @override
  void execute() {
    poderesGerais.add(controller.text);
    controller.clear();
  }
}

/// Command para remover um poder
class RemoverPoderCommand implements Command {
  RemoverPoderCommand(this.poderesGerais, this.index);
  final List<String> poderesGerais;
  final int index;

  @override
  void execute() {
    poderesGerais.removeAt(index);
  }
}

/// Command para adicionar uma magia
class AdicionarMagiaCommand implements Command {
  AdicionarMagiaCommand(this.magias, this.controller);
  final List<String> magias;
  final TextEditingController controller;

  @override
  void execute() {
    magias.add(controller.text);
    controller.clear();
  }
}

/// Command para remover uma magia
class RemoverMagiaCommand implements Command {
  RemoverMagiaCommand(this.magias, this.index);
  final List<String> magias;
  final int index;

  @override
  void execute() {
    magias.removeAt(index);
  }
}

/// Command para salvar a ficha no Firebase
class SalvarFichaCommand implements Command {
  SalvarFichaCommand(this.ficha, this.formKey, this.isEditing);
  final Ficha ficha;
  final GlobalKey<FormState> formKey;
  final bool isEditing;

  /// Função para adicionar ficha no Firebase
  Future<void> _addFicha(Ficha ficha) async {
    await FirebaseFirestore.instance.collection('fichas').add(ficha.toMap());
  }

  /// Função para atualizar ficha no Firebase
  Future<void> _updateFicha(Ficha ficha, String uID) async {
    await FirebaseFirestore.instance.collection('fichas').doc(uID).update(ficha.toMap());
  }

  @override
  Future<void> execute() async {
    if (formKey.currentState!.validate()) {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        final Ficha fichaAtualizada = Ficha(
          uID: ficha.uID, // Certifique-se de que o uID está presente
          authorUID: FirebaseAuth.instance.currentUser!.uid,
          classe: ficha.classe,
          nome: ficha.nome,
          origem: ficha.origem,
          poderesGerais: ficha.poderesGerais,
          magias: ficha.magias,
        );

        if (isEditing && ficha.uID.isNotEmpty) {
          await _updateFicha(fichaAtualizada, ficha.uID); // Atualiza ficha existente
        } else {
          await _addFicha(fichaAtualizada); // Adiciona nova ficha
        }
      }
    }
  }
}

/// Classe responsável por toda a página de Editar Ficha
class EditarFichaPage extends StatefulWidget {
  const EditarFichaPage({super.key, this.ficha});
  final Ficha? ficha;

  @override
  _EditarFichaPageState createState() => _EditarFichaPageState();
}

class _EditarFichaPageState extends State<EditarFichaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _classeController = TextEditingController();
  final TextEditingController _origemController = TextEditingController();
  final TextEditingController _poderesgeraisController = TextEditingController();
  final TextEditingController _magiasController = TextEditingController();

  List<String> _poderesgerais = <String>[];
  List<String> _magias = <String>[];
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.ficha != null) {
      _nomeController.text = widget.ficha!.nome;
      _classeController.text = widget.ficha!.classe;
      _origemController.text = widget.ficha!.origem;
      _poderesgerais = widget.ficha!.poderesGerais;
      _magias = widget.ficha!.magias;
      isEditing = true; // Define como edição
    }
  }

  @override
  void dispose() {
    _poderesgeraisController.dispose();
    _magiasController.dispose();
    super.dispose();
  }

  void _executarCommand(Command command) {
    setState(() {
      command.execute();
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
                      onPressed: () => _executarCommand(RemoverPoderCommand(_poderesgerais, index)),
                    ),
                  );
                },
              ),
              TextFormField(
                controller: _poderesgeraisController,
                decoration: const InputDecoration(labelText: 'Adicionar Poder Geral'),
              ),
              TextButton(
                onPressed: () => _executarCommand(AdicionarPoderCommand(_poderesgerais, _poderesgeraisController)),
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
                      onPressed: () => _executarCommand(RemoverMagiaCommand(_magias, index)),
                    ),
                  );
                },
              ),
              TextFormField(
                controller: _magiasController,
                decoration: const InputDecoration(labelText: 'Adicionar Magia'),
              ),
              TextButton(
                onPressed: () => _executarCommand(AdicionarMagiaCommand(_magias, _magiasController)),
                child: const Text('Adicionar'),
              ),
              TextButton(
                child: const Text('Salvar'),
                onPressed: () {
                  final Ficha ficha = Ficha(
                    uID: widget.ficha?.uID ?? '', // Utiliza o uID da ficha se estiver em edição
                    authorUID: FirebaseAuth.instance.currentUser?.uid ?? '',
                    classe: _classeController.text,
                    nome: _nomeController.text,
                    origem: _origemController.text,
                    poderesGerais: _poderesgerais,
                    magias: _magias,
                  );
                  _executarCommand(SalvarFichaCommand(ficha, _formKey, isEditing));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
