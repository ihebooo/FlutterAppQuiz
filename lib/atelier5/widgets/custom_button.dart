import 'package:flutter/material.dart';

class CustomBouton extends StatelessWidget {
  const CustomBouton({
    super.key,
    this.text = "",
    this.onpressed,
    this.couleur,
  });

  final String text;
  final void Function()? onpressed;
  final Color? couleur;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(couleur)),
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ));
  }
}