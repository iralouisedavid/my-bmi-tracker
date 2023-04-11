import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/models/result.dart';
import 'package:bmi_calculator/bmi_calculator.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'database_helper_test.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  group('BMI Result', () {

    late Database database;
    late DatabaseHelperTest databaseHelperTest;

    setUpAll(() async {
      // Initialize the binding before running the test
      WidgetsFlutterBinding.ensureInitialized();
      // Initialize the FFI bindings for sqflite
      sqfliteFfiInit();

      // Use DatabaseFactoryFfi to create an in-memory database
      databaseFactory = databaseFactoryFfi;
      database = await openDatabase(inMemoryDatabasePath);

      // Initialize databaseHelperTest with in-memory database
      databaseHelperTest = DatabaseHelperTest.getInstance(database);

      // Create the table
      await databaseHelperTest.initDatabase();
    });

    tearDown(() async {
      // Delete all test data from the database
      await database.delete('results');
    });

    test('Should insert BMI result into databaseHelperTest using sqflite inMemoryDatabasePath', () async {
      // Arrange
      const height = 170.0;
      const weight = 60.0;
      const age = 25;

      final bmi = BMICalculator(weight: weight, height: height, age: age);
      final status = bmi.getBMIStatus();

      final result = Result(
        weight: weight,
        height: height,
        age: age,
        bmi: bmi.getBMI(),
        status: status,
      );

      // Act
      print('Inserting results...');
      await databaseHelperTest.insertResult(result);

      // Assert that the inserted result is in the database
      final cachedResults = await databaseHelperTest.getResults();
      expect(cachedResults.length, equals(1));
      expect(cachedResults.first.weight, equals(weight));
      expect(cachedResults.first.height, equals(height));
      expect(cachedResults.first.age, equals(age));
      expect(cachedResults.first.bmi, equals(bmi.getBMI()));
      expect(cachedResults.first.status, equals(status));
    });

    test('Should retrieve BMI result from databaseHelperTest using sqflite inMemoryDatabasePath', () async {
      // Arrange
      const height = 170.0;
      const weight = 60.0;
      const age = 25;

      final bmi = BMICalculator(weight: weight, height: height, age: age);
      final status = bmi.getBMIStatus();

      final result = Result(
        weight: weight,
        height: height,
        age: age,
        bmi: bmi.getBMI(),
        status: status,
      );

      // Insert the result into the database
      await databaseHelperTest.insertResult(result);

      // Act
      print('Retrieving results...');
      final cachedResults = await databaseHelperTest.getResults();
      final cachedResult = cachedResults.first;

      // Assert that the retrieved result matches the inserted result
      expect(cachedResult.weight, equals(weight));
      expect(cachedResult.height, equals(height));
      expect(cachedResult.age, equals(age));
      expect(cachedResult.bmi, equals(bmi.getBMI()));
      expect(cachedResult.status, equals(status));
    });

    test('Should delete BMI result from databaseHelperTest using sqflite inMemoryDatabasePath', () async {
      // Arrange
      const height = 170.0;
      const weight = 60.0;
      const age = 25;

      final bmi = BMICalculator(weight: weight, height: height, age: age);
      final status = bmi.getBMIStatus();

      final result = Result(
        weight: weight,
        height: height,
        age: age,
        bmi: bmi.getBMI(),
        status: status,
      );

      // Insert the result into the database
      await databaseHelperTest.insertResult(result);

      // Retrieve the result from the database
      final cachedResults = await databaseHelperTest.getResults();
      final cachedResult = cachedResults.first;

      // Act
      final rowsDeleted = await databaseHelperTest.deleteResult(cachedResult.id!);

      // Assert that the number of rows deleted is 1
      expect(rowsDeleted, equals(1));

      // Assert that the databaseHelperTest is empty
      final emptyCache = await databaseHelperTest.getResults();
      expect(emptyCache.length, equals(0));

    });

    tearDownAll(() async {
      // Close the database when all the tests are done
      await database.close();
    });

  });
}
