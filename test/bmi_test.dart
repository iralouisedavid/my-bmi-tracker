import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/bmi_calculator.dart';

void main() {
  group('BMICalculator', () {
    test('Calculate BMI based on the weight and height values that falls under the normal range (18.5 - 24.9) and should return the correct BMI value and status ("Normal")', () {
      // Arrange
      const height = 175.0; // in centimeters
      const weight = 70.0; // in kilograms
      const age = 22;

      // Act
      final calculator = BMICalculator(weight: weight, height: height, age: age);

      // Assert
      expect(calculator.getBMIStatus(), 'Normal');
      expect(calculator.getBMI(), closeTo(22.86, 0.01));
    });

    test('Calculate BMI based on the weight and height values that falls under the underweight range (<18.5) and should return the correct BMI value and status ("Underweight").', () {
      // Arrange
      const height = 165.0;
      const weight = 50.0;
      const age = 22;

      // Act
      final calculator = BMICalculator(weight: weight, height: height, age: age);

      // Assert
      expect(calculator.getBMIStatus(), 'Underweight');
      expect(calculator.getBMI(), closeTo(18.37, 0.01));
    });

    test('Calculate BMI based on the weight and height values that falls under the overweight range (25 - 29.9) and should return the correct BMI value and status ("Overweight").', () {
      // Arrange
      const height = 150.0;
      const weight = 60.0;
      const age = 22;

      // Act
      final calculator = BMICalculator(weight: weight, height: height, age: age);

      // Assert
      expect(calculator.getBMIStatus(), 'Overweight');
      expect(calculator.getBMI(), closeTo(26.67, 0.01));
    });
  });
}
