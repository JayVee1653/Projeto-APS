import 'package:flutter/material.dart';
import 'package:tavernadoscombos/factories/page_factory.dart';
import 'package:tavernadoscombos/paginas/login.dart';


/// Interface para o Factory Method
class LoginPageFactory implements PageFactory {
  @override
  ///Criação das páginas
  Widget createPage() {
    return LoginPage();
  }
}
