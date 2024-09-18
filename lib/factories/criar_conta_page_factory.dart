import 'package:flutter/material.dart';
import 'package:tavernadoscombos/factories/page_factory.dart';
import 'package:tavernadoscombos/paginas/criar_conta.dart';


/// Interface para o Factory Method
class CriarContaPageFactory implements PageFactory {
  @override
  ///Criação das páginas
  Widget createPage() {
    return CriarContaPage();
  }
}
