import 'package:flutter/material.dart';
import 'package:projectdemo/atelier5/pages/Addmovie.dart';

void main() {
  runApp(GestionFilm());
}

class GestionFilm extends StatelessWidget {
  const GestionFilm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Addmovie());
  }
}
