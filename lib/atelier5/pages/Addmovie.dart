import 'package:flutter/material.dart';
import 'package:projectdemo/atelier5/db/db.helper.dart';
import 'package:projectdemo/atelier5/models/model_film.dart';
import 'package:projectdemo/atelier5/widgets/custom_checkbox.dart';
import 'package:projectdemo/atelier5/widgets/custom_radiobutton.dart';
import 'package:projectdemo/atelier5/widgets/custom_text.dart';
import 'package:projectdemo/atelier5/widgets/custom_button.dart';

class Addmovie extends StatefulWidget {
  const Addmovie({super.key});

  @override
  State<Addmovie> createState() => _AddmovieState();
}

// film: code(String de 8car), nomfilm(String de 8car), realisateur(String de 8car),anne (2000<entier < 2023 ) type:BR
//,genre: action, drama

class _AddmovieState extends State<Addmovie> {
  final formkey = GlobalKey<FormState>();
  bool valuecheck1 = false, valuecheck2 = false;
  String selectedvalue = "Drama";
  var film = Film();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter d'un nouveau Film"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  label: "Code",
                  hinttext: "Donner le code du Film",
                  uneIcone: Icons.accessible_forward,
                  clavier: TextInputType.text,
                  valider: (String? value) {
                    if (value == null || value.length == 0)
                      return "Code Film est Obligatoire!!";
                    if (value.length != 8)
                      return "Code format incorrect(8 car)";
                    return null;
                  },
                  onsaved: (value) {
                    film.setCode = value!;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                ),
                CustomText(
                  label: "Nom film",
                  hinttext: "Donner le nom du Film",
                  uneIcone: Icons.movie,
                  clavier: TextInputType.text,
                  valider: (String? value) {
                    if (value == null || value.length == 0)
                      return "Nom Film est Obligatoire!!";
                    return null;
                  },
                  onsaved: (value) {
                    film.setTitre = value!;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                ),
                CustomText(
                  label: "Realiateur",
                  hinttext: "Donner le nom réalisateur du Film",
                  uneIcone: Icons.person_2,
                  clavier: TextInputType.text,
                  valider: (String? value) {
                    if (value == null || value.length == 0)
                      return "Nom realisateur est Obligatoire!!";
                    return null;
                  },
                  onsaved: (value) {
                    film.setRealistauer = value!;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                ),
                CustomText(
                  label: "Année de Sortie",
                  hinttext: "Donner l'année ",
                  uneIcone: Icons.date_range,
                  clavier: TextInputType.number,
                  valider: (String? value) {
                    if (value == null || value.length == 0)
                      return "Année Film est Obligatoire!!";

                    if (int.parse(value) > 2000 && int.parse(value) < 2023)
                      return null;
                    return "Année film incorrecte";
                  },
                  onsaved: (value) {
                    film.setAnnee = int.parse(value!);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                ),
                FormField(
                  builder: (state) {
                    return Column(
                      children: [
                        CustomCheckBox(
                          text: "enfant",
                          value: valuecheck1,
                          onchanged: (bool? value) {
                            setState(() {
                              valuecheck1 = value!;
                            });
                          },
                        ),
                        Text(
                          state.errorText ?? '',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (valuecheck1 == false && valuecheck2 == false)
                      return "Vous devez sélectionner un choix!!!";
                    return null;
                  },
                  onSaved: (value) {
                    List<String> tmp = [];
                    if (valuecheck1 == true) tmp.add("enfant");
                    if (valuecheck2 == true) tmp.add("adulte");
                    film.setPublicCible = tmp;
                  },
                ),
                CustomCheckBox(
                  text: "adulte",
                  value: valuecheck2,
                  onchanged: (bool? value) {
                    setState(() {
                      valuecheck2 = value!;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                ),
                CustomRadioButton(
                  value: "Action",
                  groupvalue: selectedvalue,
                  text: "Action",
                  onchanged: (value) {
                    setState(() {
                      selectedvalue = value!;
                    });
                  },
                ),
                CustomRadioButton(
                  value: "Drama",
                  groupvalue: selectedvalue,
                  text: "Drama",
                  onchanged: (value) {
                    setState(() {
                      selectedvalue = value!;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomBouton(
                      text: "Sauvgarder",
                      couleur: Colors.green,
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          print("FORM OK");
                          formkey.currentState!.save();
                          film.setGenre = selectedvalue;
                          print(film);

                          DataBaseHelper db = new DataBaseHelper();
                          if (db == null) {
                            print("error db connect");
                          } else {
                            print("execute to db");

                            db.add(film);
                          }
                        } else
                          print("form NO OK");
                      },
                    ),
                    CustomBouton(
                      text: "Annuler",
                      couleur: Colors.red,
                      onpressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
