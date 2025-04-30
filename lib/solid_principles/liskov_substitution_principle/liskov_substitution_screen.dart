import 'package:flutter/material.dart';

extension type ShapeArea(double value) {}
extension type ShapeName(String value) {}
extension type ShapeColor(Color value) {}
extension type ShapeDescription(String value) {}

abstract class Shape {
  ShapeArea calculateArea();
  ShapeName draw();
  ShapeColor getColor();
}

class Square implements Shape {
  final double side;
  final Color color;

  Square(this.side, this.color);

  @override
  ShapeArea calculateArea() {
    return ShapeArea(side * side);
  }

  @override
  ShapeName draw() {
    return ShapeName("Drawing a square");
  }

  @override
  ShapeColor getColor() {
    return ShapeColor(color);
  }
}

class Circle implements Shape {
  final double radius;
  final Color color;

  Circle(this.radius, this.color);

  @override
  ShapeArea calculateArea() {
    return ShapeArea(3.14 * radius * radius);
  }

  @override
  ShapeName draw() {
    return ShapeName("Drawing a circle");
  }

  @override
  ShapeColor getColor() {
    return ShapeColor(color);
  }
}

class Rectangle implements Shape {
  final double width;
  final double height;
  final Color color;

  Rectangle(this.width, this.height, this.color);

  @override
  ShapeArea calculateArea() {
    return ShapeArea(height * width);
  }

  @override
  ShapeName draw() {
    return ShapeName("Drawing a rectangle");
  }

  @override
  ShapeColor getColor() {
    return ShapeColor(color);
  }
}

class ShapeProcessor {
  static ShapeDescription processShape(Shape shape) {
    ShapeArea area = shape.calculateArea();
    ShapeName drawResult = shape.draw();
    return ShapeDescription("$drawResult\nArea: $area square units");
  }
}

class LiskovSubstitutionScreen extends StatefulWidget {
  const LiskovSubstitutionScreen({super.key});

  @override
  _LiskovSubstitutionScreenState createState() =>
      _LiskovSubstitutionScreenState();
}

class _LiskovSubstitutionScreenState extends State<LiskovSubstitutionScreen> {
  String result = "Select a shape to draw";
  ShapeColor shapeColor = ShapeColor(Colors.black);
  Shape? currentShape;

  void _selectShape(Shape shape) {
    setState(() {
      currentShape = shape;
      result = ShapeProcessor.processShape(shape).value;
      shapeColor = shape.getColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                result,
                style: TextStyle(fontSize: 18, color: shapeColor.value),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _selectShape(Circle(5.0, Colors.red)),
                  child: const Text("Circle"),
                ),
                ElevatedButton(
                  onPressed: () => _selectShape(Square(10.0, Colors.green)),
                  child: const Text("Square"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
