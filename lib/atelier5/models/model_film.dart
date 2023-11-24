// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Film {
  String code;
  String titre;
  String realistauer;
  int annee;
  String genre;
  List<String>? publicCible;

  Film({
    this.code = "",
    this.titre = "",
    this.realistauer = "",
    this.annee = 0,
    this.genre = "",
    this.publicCible = null,
  });

  String get getCode => this.code;
  set setCode(String code) => this.code = code;
  get getTitre => this.titre;
  set setTitre(titre) => this.titre = titre;
  get getRealistauer => this.realistauer;
  set setRealistauer(realistauer) => this.realistauer = realistauer;
  get getAnnee => this.annee;
  set setAnnee(annee) => this.annee = annee;
  get getGenre => this.genre;
  set setGenre(genre) => this.genre = genre;
  get getPublicCible => this.publicCible;
  set setPublicCible(publicCible) => this.publicCible = publicCible;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'titre': titre,
      'realistauer': realistauer,
      'annee': annee,
      'genre': genre,
      'publicCible': publicCible,
    };
  }

  factory Film.fromMap(Map<String, dynamic> map) {
    return Film(
      code: map['code'] as String,
      titre: map['titre'] as String,
      realistauer: map['realistauer'] as String,
      annee: map['annee'] as int,
      genre: map['genre'] as String,
      publicCible: List<String>.from((map['publicCible'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Film.fromJson(String source) =>
      Film.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Film(code: $code, titre: $titre, realistauer: $realistauer, annee: $annee, genre: $genre, publicCible: $publicCible)';
  }
}
