import 'package:flutter_test/flutter_test.dart';

String validateAge(int age) {
  if (age >= 18 && age <= 65) return "Valid age";
  if (age < 18) return "Too young";
  return "Too old";
}

void main() {
  group('Age validation tests', () {
    test('Should return "Too young" when age is below 18', () {
      expect(validateAge(17), "Too young", );
    });

    test('Should return "Valid age" when age is exactly 18', () {
      expect(validateAge(18), "Valid age");
    });

    test('Should return "Valid age" when age is within the range 18-65', () {
      expect(validateAge(30), "Valid age");
    });

    test('Should return "Valid age" when age is exactly 65', () {
      expect(validateAge(65), "Valid age");
    });

    test('Should return "Too old" when age is above 65', () {
      expect(validateAge(66), "Too old");
    });
  });
}
