import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    this.text = "",
    this.onchanged,
    required this.value,
    required this.groupvalue,
  });
  final String text;
  final String groupvalue;
  final void Function(String?)? onchanged;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupvalue,
          onChanged: onchanged,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.blue, fontSize: 18),
        )
      ],
    );
  }
}
