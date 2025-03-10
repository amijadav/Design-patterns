// import 'package:design_patterns/unit_test.dart';
import 'package:design_patterns/unit_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'unit_mock.mocks.dart';

void main() {
  group('Basic Functionality Testing', () {
    test('Product initialization', () {
      final product = Product(name: "Laptop", price: 1000, stock: 5);
      expect(product.name, "Laptop");
      expect(product.price, 1000);
      expect(product.stock, 5);
    });
  });

  group('Boundary Testing', () {
    test('Stock boundary values', () {
      final product = Product(name: "Phone", price: 500, stock: 0);
      expect(product.isInStock, false);

      product.stock = 1;
      expect(product.isInStock, true);
    });
  });

  group('Equivalence Partitioning', () {
    test('Discount calculation for valid ranges', () {
      final product = Product(name: "TV", price: 2000, stock: 3);
      expect(product.calculateDiscountedPrice(10), 1800);
      expect(product.calculateDiscountedPrice(50), 1000);
    });
  });

  group('Parameterized Testing', () {
    final testCases = [
      {"price": 1000, "discount": 20, "expected": 800.0},
      {"price": 500, "discount": 10, "expected": 450.0},
      {"price": 200, "discount": 0, "expected": 200.0}
    ];

    for (var testCase in testCases) {
      test('Price: \${testCase["price"]} with discount \${testCase["discount"]}', () {
        final product =
            Product(name: "Table", price: double.parse('${testCase["price"]}'), stock: 2);
        expect(product.calculateDiscountedPrice(double.parse('${testCase["discount"]}')),
            testCase["expected"]);
      });
    }
  });

  group('Exception Handling Testing', () {
    test('Invalid discount throws ArgumentError', () {
      final product = Product(name: "Sofa", price: 1500, stock: 4);
      expect(() => product.calculateDiscountedPrice(-10), throwsArgumentError);
      expect(() => product.calculateDiscountedPrice(110), throwsArgumentError);
    });
  });

  group('Asynchronous Testing', () {
    test('fetchProductName returns expected result', () async {
      expect(await fetchProductName(), "Sample Product");
    });
  });

  group('Mock Testing', () {
    late MockApiService mockService;

    setUp(() {
      mockService = MockApiService();
    });

    test('Mock API returns expected data', () async {
      when(mockService.fetchData()).thenAnswer((_) async => "Mocked API Data");

      expect(await mockService.fetchData(), "Mocked API Data");
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
