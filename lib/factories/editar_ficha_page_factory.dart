import 'package:flutter/material.dart';
import 'package:tavernadoscombos/factories/page_factory.dart';
import 'package:tavernadoscombos/paginas/editar_ficha.dart';


/// Interface para o Factory Method
class EditarFichaPageFactory implements PageFactory {
  @override
  ///Criação das páginas
  Widget createPage() {
    return const EditarFichaPage();
  }
}
