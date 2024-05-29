import 'dart:convert';

import 'package:flutter_2024_aau_connectify/data_providers/user_data_provider.dart';

class UserRepository {
  final UserDataProvider userDataProvider;
  UserRepository(this.userDataProvider);

  Future<bool> checkStudent(String studentId, String studentPassword) async {
    try {
      final response =
          await userDataProvider.checkStudent(studentId, studentPassword);
      if (response['statusCode'] >= 200 && response['statusCode'] < 300) {
        final data = jsonDecode(response['body']);
        return data['exists'];
      }
      return false;
    } catch (e) {
      //}
    }
    return false;
  }

  //make the registerUser method
  Future<bool> registerUser(String fullName, String email, String password,
      String studentId, String studentPassword) async {
    try {
      final response = await userDataProvider.registerUser(
          fullName, email, password, studentId, studentPassword);
      if (response['statusCode'] >= 200 && response['statusCode'] < 300) {
        final data = jsonDecode(response['body']);
        if (data['message'] ==
            'User registered successfully. Verification code sent to your email.') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //verify USER EMAIL
  Future<bool> verifyUserEmail(String email, String verificationCode) async {
    try {
      final response =
          await userDataProvider.verifyEmail(email, verificationCode);
    print(response);
      if (response['statusCode'] < 200 || response['statusCode'] > 300) return false;

      final data = jsonDecode(response['body']);

      if (data['message'] != 'Email verified successfully.'){
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  //login method
  Future<Map> login(String email, String password) async {
    try {
      final response = await userDataProvider.login(email, password);

      if (response['statusCode'] < 200 || response['statusCode'] > 300) return {'success': false};

      final data = jsonDecode(response['body']);
      return {'success': true, 'token': data['accessToken']};
    } catch (e) {
      return {'statusCode': 500};
    }
  }
  
}
