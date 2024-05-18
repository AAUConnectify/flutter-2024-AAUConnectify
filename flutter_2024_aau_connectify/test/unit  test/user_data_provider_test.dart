import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_2024_aau_connectify/data_providers/user_data_provider.dart';

void main() {
  group('UserDataProvider', () {
    test('checkStudent should return a valid response', () async {
      // Arrange
      final userDataProvider = UserDataProvider();
      const studentId = 'new_student_id';
      const password = 'your_password';

      // Act
      final response = await userDataProvider.checkStudent(studentId, password);
      // Assert
      expect(response, isNotNull);
      //check if the statusCode is in the range of grater then 200 and less than 300
      expect(response['statusCode'], greaterThanOrEqualTo(200));
      expect(response['statusCode'], lessThan(300));
     
      // Add more assertions based on the expected response
    });

    

    /// Test the createStudent method
    test('createStudent should return a valid response', () async {
      // Arrange
      final userDataProvider = UserDataProvider();
      const studentId = 'ugr/2324/14';
      const password = 'pass';

      // Act
      final response =
          await userDataProvider.createStudent(studentId, password);

      // Assert
      expect(response, isNotNull);
      // Add more assertions based on the expected response
    });
    ///Testing the registerUser Method

    test('RegisterUser ', () async {
      // Arrange
     
      final userDataProvider = UserDataProvider();
      const String fullName = 'John Doe';
      const String email = "fuad.mohammed@a2sv.org";
      const String password = "password123";
      const String studentId = "ugr/9999/14";
      const String studentPassword = "pass";
      // Act & Assert
      final response = await userDataProvider.registerUser(
          fullName, email, password, studentId, studentPassword);
      expect(response, isNotNull);
      // Add more assertions based on the expected response
    });

    /// verifyEmail Method
    
    test('verifyEmail should return a valid response', () async {
      // Arrange
      final userDataProvider = UserDataProvider();
      const email = 'fuad.mohammed@a2sv.org';
      const code = 'UZL1PE';

      // Act & Assert
      final response = await userDataProvider.verifyEmail(email, code);
      print(response);
      expect(response, isNotNull);
    });
  });

  ///Testing the login Method
  
  test('login should return a valid response', () async {
  // Arrange
  final userDataProvider = UserDataProvider();
  const email = 'fuad.mohammed@a2sv.org';
  const password = 'pass';

  // Act
  final response = await userDataProvider.login(email, password);
  final data = jsonDecode(response['body']);
  print(data);

  // Assert
  
});


}
