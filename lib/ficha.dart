class Ficha {
  String Uid;
  String Author_uid;
  String Classe;
  String Nome;
  String Origem;
  List<String> Magias;
  List<String> Poderes_gerais;

  Ficha(
      {this.Uid = '',
      required this.Author_uid,
      required this.Classe,
      required this.Nome,
      required this.Origem,
      required this.Magias,
      required this.Poderes_gerais});
  
  Map<String, dynamic> toMap() {
    return {
      'Author_uid': Author_uid,
      'Classe': Classe,
      'Nome': Nome,
      'Origem': Origem,
      'Poderes_gerais': Poderes_gerais,
      'Magias': Magias,
    };
  }

}