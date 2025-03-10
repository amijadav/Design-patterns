import 'package:flutter/material.dart';

class ButtonExample extends StatefulWidget {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color fontColor;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonExample({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    required this.fontColor,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<ButtonExample> createState() => _ButtonExampleState();
}

class _ButtonExampleState extends State<ButtonExample> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor, side: BorderSide(color: widget.borderColor)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.icon,
            color: Colors.white,
          ),
          Text(
            widget.label,
            style: TextStyle(color: widget.fontColor),
          ),
        ],
      ),
    );
  }
}

class CustomButtonBuilder {
  String label = 'Click me';
  Color backgroundColor = Colors.blue;
  Color borderColor = Colors.black38;
  Color fontColor = Colors.black54;
  IconData icon = Icons.add;
  void Function()? onPressed;

  CustomButtonBuilder setLabel(String label) {
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(label)) {
      throw Exception(
        'The label text must follows the format: A to Z, without '
        'case sensitive, including white spaces',
      );
    }
    this.label = label;
    return this;
  }

  CustomButtonBuilder setColor(Color backgroundColor) {
    this.backgroundColor = backgroundColor;
    return this;
  }

  CustomButtonBuilder setBorderColor(Color borderColor) {
    this.borderColor = borderColor;
    return this;
  }

  CustomButtonBuilder setIcon(IconData icon) {
    this.icon = icon;
    return this;
  }

  CustomButtonBuilder setfontColor(Color fontColor) {
    this.fontColor = fontColor;
    return this;
  }

  CustomButtonBuilder setOnPress(void Function() onPressed) {
    this.onPressed = onPressed;
    return this;
  }

  ButtonExample build() {
    return ButtonExample(
      label: label,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      icon: icon,
      onPressed: () {},
      fontColor: fontColor,
    );
  }
}

class BuilderPatternExample extends StatefulWidget {
  const BuilderPatternExample({super.key});

  @override
  State<BuilderPatternExample> createState() => _BuilderPatternExampleState();
}

class _BuilderPatternExampleState extends State<BuilderPatternExample> {
  @override
  Widget build(BuildContext context) {
    var builder = CustomButtonBuilder().setLabel('Click Me').setColor(Colors.blue);

// do some other stuffs. api call firebase call or else

    final finalWidget = builder
        .setIcon(Icons.add)
        .setfontColor(Colors.black)
        .setOnPress(
          () {},
        )
        .build();

    return MaterialApp(
      title: 'Builder pattern App',
      home: Scaffold(
        body: Center(child: finalWidget),
      ),
    );
  }
}
