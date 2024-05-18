import 'dart:convert';

import 'package:flutter_2024_aau_connectify/infrastructure/data_providers/user_data_provider.dart';

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
  Future<Map> verifyUserEmail(String email, String verificationCode) async {
    try {
      final response =
          await userDataProvider.verifyEmail(email, verificationCode);
      if (response['statusCode'] < 200 || response['statusCode'] > 300){
        return {'success': false, 'message': 'Failed to verify email'};}

      final data = jsonDecode(response['body']);

      if (data['message'] != 'Email verified successfully.') {
        return {'success': false, 'message': 'Failed to verify email'};
      }

      return {'success': true, 'body': data};
    } catch (e) {
      return {'success': false, 'message': 'Failed to verify email'};
    }
  }

  //login method
  Future<Map> login(String email, String password) async {
    try {
      final response = await userDataProvider.login(email, password);

      if (response['statusCode'] < 200 || response['statusCode'] > 300)
        return {'success': false};

      final data = jsonDecode(response['body']);
      return {'success': true, 'token': data['accessToken']};
    } catch (e) {
      return {'statusCode': 500};
    }
  }

  //get user details
  Future<Map> getUserDetails(String token) async {
    try {
      final response = await userDataProvider.getUserDetails(token);
      if (response['success'] == false)
        return {'success': false, 'message': 'Failed to get user details'};
      final data = jsonDecode(response['body']);
      return {'success': true, 'user': data};
    } catch (e) {
      return {'success': false, 'message': 'Failed to get user details'};
    }
  }

  Future<Map> changeRole(String newRole, String userId, String token) async {
    try {
      final response =
          await userDataProvider.changeRole(newRole, userId, token);
      if (response['success'] == false)
        return {'success': false, 'message': 'Failed to change the role'};
      final data = jsonDecode(response['body']);
      return {'success': true, 'user': data};
    } catch (e) {
      return {'success': false, 'message': 'Failed to change the role'};
    }
  }

  Future<Map> getProfile(String token) async {
    try {
      final response = await userDataProvider.getProfle(token);
      print('response: $response');
      if (response['success'] == false) {
        return {'success': false, 'message': 'Failed to change the role'};
      }
      final data = response['body'];
      return {'success': true, 'user': data};
    } catch (e) {
      return {'success': false, 'message': 'Failed to change the role'};
    }
  }

  Future<Map> createProfile(String token, String fullName, String fieldOfStudy,
      String bio, String profilePicture) async {
    try {
      final response = await userDataProvider.createProfile(
          token, fullName, fieldOfStudy, bio, profilePicture);
      if (response['success'] == false) {
        return {'success': false, 'message': 'Failed to create Profile'};
      }
      final data = response['body'];
      return {'success': true, 'user': data['profile']};
    } catch (e) {
      return {'success': false, 'message': 'Failed to create the profile'};
    }
  }
}
