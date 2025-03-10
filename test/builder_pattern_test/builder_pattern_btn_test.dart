import 'package:design_patterns/design_patterns/builder_pattern_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CustomButtonBuilder Tests', () {
    test('Button should display the correct label', () {
      var builder = CustomButtonBuilder();
      expect(builder.setLabel('Custom').build().label, 'Custom',
          reason: 'The label should be customizable');
      expect(builder.setLabel('Custom Two').build().label, 'Custom Two',
          reason: 'The label should be change more than once');

      expect(
        () => builder.setLabel(''),
        throwsA(isA<Exception>()),
        reason: 'The label should\'t be left blank or contain an empty value',
      );

      expect(builder.setLabel('A').build().label, 'A',
          reason: 'The label must be customizable if the label is not empty');

      expect(
        builder.build().label,
        'Click me',
        reason: 'When no label is defined using setLabel, the button built'
            'must have as default label "Click Me"',
      );
      expect(
        () => builder.setLabel('&'),
        throwsA(isA<Exception>()),
        reason: 'The label must not contain special characters, only letters'
            'A to Z, without case sensitive, including white spaces',
      );
      expect(
        () => builder.setLabel('test 1'),
        returnsNormally,
        reason: 'The label must only contains letters'
            'A to Z, without case sensitive, including white spaces',
      );
    });

    test('Button should display the correct background color', () {
      var builder = CustomButtonBuilder();
      expect(builder.setColor(Colors.blue).build().backgroundColor, Colors.blue,
          reason: 'The button must stand out clearly to be easily noticed');
    });

    test('Button should display the correct font color', () {
      var builder = CustomButtonBuilder();
      expect(builder.setfontColor(Colors.black54).build().fontColor, Colors.black54,
          reason: 'Text should be clear and readable to help users understand the button purpose');
    });

    test('Button should display the correct border color', () {
      var builder = CustomButtonBuilder();
      expect(builder.setBorderColor(Colors.black38).build().borderColor, Colors.black38,
          reason: 'Clear boundaries show the clickable area');
    });

    test('Button should display the correct icon', () {
      var builder = CustomButtonBuilder();
      expect(builder.setIcon(Icons.add).build().icon, Icons.add,
          reason: 'Visual symbols quickly convey the button purpose');
    });

    test('Button should call onPressed when clicked', () {
      var isPressed = false;
      final builder = CustomButtonBuilder()
        ..setOnPress(() {
          isPressed = true;
        });
      builder.build().onPressed();
      expect(isPressed, true, reason: 'Clicking should provide immediate action feedback');
    });
  });
}
