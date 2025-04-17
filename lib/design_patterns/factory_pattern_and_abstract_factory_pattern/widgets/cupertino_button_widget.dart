import 'package:flutter/cupertino.dart';

class CupertinoButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;

  const CupertinoButtonWidget(
      {super.key,
      required this.color,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: color,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
