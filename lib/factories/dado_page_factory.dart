import 'package:flutter/material.dart';
import 'package:tavernadoscombos/factories/page_factory.dart';
import 'package:tavernadoscombos/paginas/dado.dart';


/// Interface para o Factory Method
class DadoPageFactory implements PageFactory {
  @override
  ///Criação das páginas
  Widget createPage() {
    return const DadoPage();
  }
}
