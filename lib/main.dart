import 'package:flutter/material.dart';
import 'home_page.dart'; // Importe la page d'accueil

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Utilise HomePage comme page d'accueil
    );
  }
}
