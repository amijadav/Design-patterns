import 'package:flutter/material.dart';

abstract class Coffee {
  String getDescription();
  double getCost();
  bool isAdded(Type type);
}

abstract class CoffeeDecorator implements Coffee {
  final Coffee coffee;
  CoffeeDecorator(this.coffee);

  static Coffee resetSimpleCoffee() => _SimpleCoffee();
  static Coffee addMilk(Coffee coffee) => _MilkDecorator(coffee);
  static Coffee addSugar(Coffee coffee) => _SugarDecorator(coffee);
}

class _SimpleCoffee implements Coffee {
  @override
  String getDescription() => "Simple Coffee";

  @override
  double getCost() => 5.0;

  @override
  bool isAdded(Type type) {
    return false;
  }
}

class _MilkDecorator extends CoffeeDecorator {
  _MilkDecorator(super.coffee);

  @override
  String getDescription() => "${super.coffee.getDescription()} + Milk";

  @override
  double getCost() => super.coffee.getCost() + 1.5;

  @override
  bool isAdded(Type type) {
    if (type == _MilkDecorator) return true;
    return super.coffee.isAdded(type);
  }
}

class _SugarDecorator extends CoffeeDecorator {
  _SugarDecorator(super.coffee);

  @override
  String getDescription() => "${super.coffee.getDescription()} + Sugar";

  @override
  double getCost() => super.coffee.getCost() + 0.5;

  @override
  bool isAdded(Type type) {
    if (type == _SugarDecorator) return true;
    return super.coffee.isAdded(type);
  }
}

class CoffeeScreen extends StatefulWidget {
  const CoffeeScreen({super.key});

  @override
  _CoffeeScreenState createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen> {
  Coffee coffee = CoffeeDecorator.resetSimpleCoffee();

  void clearOptions() {
    setState(() {
      coffee = CoffeeDecorator.resetSimpleCoffee();
    });
  }

  void addMilk() {
    setState(() {
      coffee = CoffeeDecorator.addMilk(coffee);
    });
  }

  void addSugar() {
    setState(() {
      coffee = CoffeeDecorator.addSugar(coffee);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Decorator Pattern - Coffee")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              coffee.getDescription(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "\$${coffee.getCost().toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: coffee.isAdded(_MilkDecorator) ? null : addMilk,
              child: const Text("Add Milk"),
            ),
            ElevatedButton(
              onPressed: coffee.isAdded(_SugarDecorator) ? null : addSugar,
              child: const Text("Add Sugar"),
            ),
            ElevatedButton(
              onPressed: clearOptions,
              child: const Text("Clear options"),
            ),
          ],
        ),
      ),
    );
  }
}
