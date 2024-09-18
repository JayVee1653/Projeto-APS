import 'package:flutter/material.dart';
import 'package:tavernadoscombos/factories/page_factory.dart';
import 'package:tavernadoscombos/paginas/taverneiro.dart';


/// Interface para o Factory Method
class TaverneiroPageFactory implements PageFactory {
  @override
  ///Criação das páginas
  Widget createPage() {
    return const TaverneiroPage();
  }
}
