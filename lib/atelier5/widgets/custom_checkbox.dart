import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
  super.key,
  this.text = "",
  this.onchanged,
  required this.value ,
  });

  final String text;
  final void Function(bool?)? onchanged;
  final bool? value;

  @override
  Widget build(BuildContext context) {
  return Row(
    children: [
      Checkbox (value : value , onChanged: onchanged,),
      Text(text , style: TextStyle(color: Colors.blue,fontSize: 18),)
    ],

  );
  }
  }
