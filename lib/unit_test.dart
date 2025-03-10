import 'package:mockito/annotations.dart';

class Product {
  final String name;
  final double price;
  int stock;

  Product({required this.name, required this.price, required this.stock});

  bool get isInStock => stock > 0;

  double calculateDiscountedPrice(double discountPercentage) {
    if (discountPercentage < 0 || discountPercentage > 100) {
      throw ArgumentError("Discount must be between 0 and 100");
    }
    return price - (price * discountPercentage / 100);
  }
}

Future<String> fetchProductName() async {
  await Future.delayed(const Duration(seconds: 1));
  return "Sample Product";
}

@GenerateMocks([ApiService])
abstract class ApiService {
  Future<String> fetchData();
}

class ExampleApiService implements ApiService {
  @override
  Future<String> fetchData() async => "Mocked API Data";
}
