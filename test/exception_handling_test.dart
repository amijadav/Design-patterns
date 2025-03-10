import 'package:flutter_test/flutter_test.dart';

String validateInput(String text) {
  if (text.isEmpty) throw Exception('Input cannot be empty');
  return text;
}

void main() {
  test('Exception handling test', () {
    expect(() => validateInput(''), throwsA(isA<Exception>()));
    expect(() => validateInput('        '), returnsNormally,
        reason: "validateInput should not consider white spaces as empty input");
    expect(() => validateInput('a'), returnsNormally, reason: "validateInput should not throw");
  });
}
