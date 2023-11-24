import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      this.label = "",
      this.hinttext = "",
      this.uneIcone,
      this.clavier,
      this.valider,
      this.onsaved});
  final String label;
  final String hinttext;
  final IconData? uneIcone;
  final TextInputType? clavier;
  final String? Function(String?)? valider;

  final String? Function(String?)? onsaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontSize: 18.0, color: Colors.blue, fontWeight: FontWeight.bold),
      keyboardType: clavier,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(fontSize: 22.0),
        hintText: hinttext,
        hintStyle: TextStyle(fontSize: 18.0),
        prefixIcon: Icon(uneIcone),
        fillColor: Colors.yellow.withOpacity(0.3),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
      ),
      validator: valider,
      onSaved: onsaved,
    );
  }
}
