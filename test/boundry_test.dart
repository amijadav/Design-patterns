import 'package:flutter_test/flutter_test.dart';

double calculatePrice(int quantity) {
  if (quantity < 0) throw NegativeQuantityException();
  return quantity >= 100 ? 1000 : (quantity >= 1 ? quantity * 10 : 0);
}

const int maxInteger = 0x7FFFFFFFFFFFFFFF;
const int minInteger = -0x8000000000000000;
void main() {
  test('Price calculation boundary values', () {
    expect(() => calculatePrice(minInteger), throwsA(isA<NegativeQuantityException>()));
    expect(() => calculatePrice(-1), throwsA(isA<NegativeQuantityException>()));
    expect(calculatePrice(0), 0);
    expect(calculatePrice(1), 10);
    expect(calculatePrice(2), 20);
    expect(calculatePrice(99), 990);
    expect(calculatePrice(100), 1000);
    expect(calculatePrice(101), 1000);
    expect(calculatePrice(maxInteger), 1000);
  });
}

class NegativeQuantityException implements Exception {
  @override
  String toString() {
    return 'The quantity can not be negative';
  }
}
