# Changelog

## Version 1.0.0 - 2023-03-16
* Initial release of the app.

## Version 1.1.0 - 2023-03-17
* Added the ability to generate random input value for age using the RandomUser API by clicking on the "Generate Age" button.
* Added an API service to retrieve random user data from the RandomUser API.
* Created separate validators file to handle form field validations.
* Fixed minor bugs and improved overall app performance.
* Enhanced code readability and maintainability by adding comments.

## Version 1.2.0 - 2023-03-21
* Modified api.dart to fetch random user data from the Random User API using a separate function that returns a User object instead of returning data directly.
* Created a separate user.dart file to define the User class.
* Replaced setState() with a ValueNotifier to update the UI when the age is generated.
* Updated the code to fetch a random user age from the API and display it in the UI using a ValueNotifier.
* Added a ValueNotifier to hold the list of results in the ResultsScreen widget.
* Utilized AnimatedBuilder to rebuild the ListView only when the ValueNotifier is changed, boosting performance and reducing needless rebuilds.
* Modified the _loadResults() function to update the ValueNotifier instead of calling setState(), improving separation of concerns and reducing unnecessary rebuilds.
* Enhanced code readability and maintainability by adding more comments.

## Version 1.3.0 - 2023-03-22
* Added a Clear button to the BMI Calculator screen that allows users to easily clear the values in the height, weight, and age text boxes, without having to manually delete the input.
* The Clear button is positioned next to the Calculate button for easy access and is designed to stretch to the width of the screen to improve usability.
* Fixed minor bugs and improved app performance.

## Version 1.4.0 - 2023-04-11
* Added unit testing for BMI calculation
* Added unit testing for the CRUD operations of the BMI database using mock SQFlite database
* Added unit testing for BMI validators