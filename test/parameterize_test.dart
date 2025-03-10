import 'package:flutter_test/flutter_test.dart';

double calculateDiscount(double amount) {
  if (amount >= 1000) {
    double discountedValue = amount * 0.2;
    String discountAMountString = discountedValue.toStringAsFixed(2);
    return double.parse(discountAMountString);
  }
  if (amount >= 500) {
    double discountedValue = amount * 0.1;
    String discountAMountString = discountedValue.toStringAsFixed(2);
    return double.parse(discountAMountString);
  }
  if (amount >= 0) {
    return amount;
  }
  throw NegativeAMountException();
}

class NegativeAMountException implements Exception {
  @override
  String toString() {
    return 'Negative amounts are not allowed to calculate discount';
  }
}

class DiscountGreaterThanTwentyPercent implements Exception {
  @override
  String toString() {
    return 'Discount should not be greater than 20%';
  }
}

void main() {
  final testCases = [
    {
      "amount": 1001.0,
      "expected": 200.2,
      "reason": "For a total of \$1001, a 20% discount applies."
    },
    {
      "amount": 1000.0,
      "expected": 200.0,
      "reason": "Spending exactly \$1000 qualifies for a 20% discount."
    },
    {"amount": 999.99, "expected": 99.999, "reason": "With \$999.99 spent,get a 10% discount."},
    {"amount": 800.0, "expected": 80.0, "reason": "A total of \$800 gets a 10% discount."},
    {"amount": 500.0, "expected": 50.0, "reason": "Spending \$500 qualifies for a 10% discount."},
    {
      "amount": 499.99,
      "expected": 499.99,
      "reason":
          "With \$499.99 spent, no discount is applied since the minimum amount for a discount is \$500."
    },
    {"amount": 0.0, "expected": 0.0, "reason": "No purchase made, so no discount is applicable."},
    {"amount": -100.0, "expected": 0.0, "reason": "Negative values are not valid for discounts."},
  ];

  group('Discount calculation test', () {
    test('Negative amount should throw an exception', () {
      expect(
        () => calculateDiscount(-0.01),
        throwsA(isA<NegativeAMountException>()),
        reason: 'The amount -0.01 should throw an exception as the amount closer then 0',
      );
      expect(
        () => calculateDiscount(-1),
        throwsA(isA<NegativeAMountException>()),
        reason: 'The Next negative int closer than 0 should throw an exception',
      );
      expect(
        () => calculateDiscount(double.negativeInfinity),
        throwsA(isA<NegativeAMountException>()),
        reason: 'The larger negative value should throw an exception',
      );
      expect(
        () => calculateDiscount(0),
        returnsNormally,
        reason: 'The 0 amount should not throw an exception',
      );
    });

    test('Amount range which does not have any discounts', () {
      expect(
        calculateDiscount(0),
        0,
        reason: 'The amount 0 should not have any discounts.',
      );
      expect(
        calculateDiscount(0.01),
        0.01,
        reason: 'The amount 0.01 is not valid for any discount.',
      );
      expect(
        calculateDiscount(1),
        1,
        reason: 'The amount of 1 which is a closer integer should not have any discount.',
      );
      expect(
        calculateDiscount(499.99),
        499.99,
        reason:
            'The amount 499.99, which is the closer value from the next range, should not have nay discount.',
      );
    });
//amount >= 500
//amount >= 1000
    test('Amount range which have 10% discount', () {
      expect(calculateDiscount(500), 50,
          reason: 'The amount 500 get 10% discount, which means it will get product in 450.');
      expect(calculateDiscount(500.01), 50.00,
          reason:
              'The amount 500.01 get 10% discount, the amount after discount should be 449.99.');
      expect(calculateDiscount(999.99), closeTo(99.99, 100.0),
          reason: 'The amount 999.99 gets a 10% discount, so it should be approximately 99.99');
    });

    test('Amount range which have 20% discount', () {
      expect(calculateDiscount(1000), 200,
          reason: 'The amount 1000 get 20% discount, which means it will get product in 800.');
      expect(calculateDiscount(1000.01), 200.00,
          reason: 'The amount 1000.01 get 20% discount, the amount after discount should be 800.');
      expect(calculateDiscount(double.maxFinite), double.maxFinite * 0.2,
          reason: 'The larger amount get 20% discount');
    });
  });
}
