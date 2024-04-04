/// Classe responsável por manter todas as informações da ficha
class Ficha {
  /// Chamadas das informações das fichas
  Ficha(
      {this.uID = '',
      required this.authorUID,
      required this.classe,
      required this.nome,
      required this.origem,
      required this.magias,
      required this.poderesGerais,});
  ///String responsável por armazenar o userID
  String uID;
  ///String responsável por armazenar o UID do Autor da Ficha
  String authorUID;
  ///String responsável por armazenar a classe da Ficha
  String classe;
  ///String responsável por armazenar o nome da Ficha
  String nome;
  ///String responsável por armazenar a origem da Ficha
  String origem;
  ///String responsável por armazenar as magias da Ficha
  List<String> magias;
  ///String responsável por armazenar os Poderes Gerais da Ficha
  List<String> poderesGerais;
  
  /// Armazenamento das informações
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Author_uid': authorUID,
      'Classe': classe,
      'Nome': nome,
      'Origem': origem,
      'Poderes_gerais': poderesGerais,
      'Magias': magias,
    };
  }

}
