import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/validators/bmi_validators.dart';

void main() {
  // Arrange - Define the input data for the test
  group('Validators', () {
    test('Weight validator returns error message for empty input', () {
      // Arrange
      String input = '';

      // Act - Call the function being tested
      String? result = validateWeight(input);

      // Assert - Check that the function returns the expected result
      expect(result, 'Enter your weight in kilograms');
    });

    test('Weight validator returns error message for invalid input', () {
      // Arrange
      String input = '700';

      // Act
      String? result = validateWeight(input);

      // Assert
      expect(result, 'Please enter a valid weight');
    });

    test('Weight validator returns null for valid input', () {
      // Arrange
      String input = '70';

      // Act
      String? result = validateWeight(input);

      // Assert
      expect(result, null);
    });

    test('Height validator returns error message for empty input', () {
      // Arrange
      String input = '';

      // Act
      String? result = validateHeight(input);

      // Assert
      expect(result, 'Enter your height in centimeters');
    });

    test('Height validator returns error message for invalid input', () {
      // Arrange
      String input = '300';

      // Act
      String? result = validateHeight(input);

      // Assert
      expect(result, 'Please enter a valid height');
    });

    test('Height validator returns null for valid input', () {
      // Arrange
      String input = '170';

      // Act
      String? result = validateHeight(input);

      // Assert
      expect(result, null);
    });

    test('Age validator returns error message for empty input', () {
      // Arrange
      String input = '';

      // Act
      String? result = validateAge(input);

      // Assert
      expect(result, 'Please enter your age');
    });

    test('Age validator returns error message for invalid input', () {
      // Arrange
      String input = '0';

      // Act
      String? result = validateAge(input);

      // Assert
      expect(result, 'Please enter a valid age');
    });

    test('Age validator returns null for valid input', () {
      // Arrange
      String input = '30';

      // Act
      String? result = validateAge(input);

      // Assert
      expect(result, null);
    });
  });
}
