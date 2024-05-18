import 'dart:convert';

import 'package:flutter_2024_aau_connectify/infrastructure/data_providers/user_data_provider.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserDataProvider extends Mock implements UserDataProvider {}

void main(){
  
  group('testing the User Repo', () { 

    final mockUserDataProvider = MockUserDataProvider();
    final mockRepo = UserRepository(mockUserDataProvider);
   
    setUp(() {
      when(() => mockUserDataProvider.checkStudent('studentId', 'password')).thenAnswer((_) async => {'body': jsonEncode({'exists':true}), 'statusCode': 200});
      when(() => mockUserDataProvider.createStudent('studentId', 'password')).thenAnswer((_) async => {'body': 'bocdy', 'statusCode': 200});
      when(() => mockUserDataProvider.registerUser('fullName', 'email', 'password', 'studentId', 'studentPassword')).thenAnswer((_) async =>{'body': jsonEncode({'message':'User registered successfully. Verification code sent to your email.'}), 'statusCode': 200});
      when(() => mockUserDataProvider.verifyEmail('email', 'code')).thenAnswer((_) async =>{'body': jsonEncode({'message':'Email verified successfully.'}), 'statusCode': 200});
      when (() => mockUserDataProvider.login('email', 'password')).thenAnswer((_) async =>{'body': jsonEncode({'token':'token'}), 'statusCode': 200});

    });

    test('checkStudent should return a valid response', () async {
      final response = await mockRepo.checkStudent('studentId', 'password');
      expect(response, true);
    });

    test('login should return a valid response', () async {
      final response = await mockRepo.login('email', 'password');
      expect(response['success'], true);
    });
  
    test('registerUser should return a valid response', () async {
      final response = await mockRepo.registerUser('fullName', 'email', 'password', 'studentId', 'studentPassword');
      expect(response, true);
    }); 

    test('verifyEmail should return a valid response', () async {
      final response = await mockRepo.verifyUserEmail('email', 'code');
      expect(response['success'], true);
    });
  });
}