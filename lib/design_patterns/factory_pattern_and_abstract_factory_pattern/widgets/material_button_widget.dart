import 'package:flutter/material.dart';

class MaterialButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;

  const MaterialButtonWidget(
      {super.key,
      required this.color,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(text),
    );
  }
}
