import 'package:flutter/material.dart';

/// Interface para o Factory Method
abstract class PageFactory {
  ///Criação das páginas
  Widget createPage();
}
