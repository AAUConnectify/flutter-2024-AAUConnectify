import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_2024_aau_connectify/secret.dart';

class UserDataProvider {
  Future<Map> checkStudent(String studentId, String password) async {
    try {
      Uri url =
          Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.checkStudent}');
      String body =
          jsonEncode({"studentId": studentId, "studentPassword": password});
      final responce = await http
          .post(url, body: body, headers: {"content-type": "application/json"});

      return {'body': responce.body, 'statusCode': responce.statusCode};
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map> createStudent(String studentId, String password) async {
    try {
      Uri url =
          Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.createStudent}');
      String body =
          jsonEncode({"studentId": studentId, "studentPassword": password});
      final responce = await http
          .post(url, body: body, headers: {"content-type": "application/json"});

      return {'body': responce.body, 'statusCode': responce.statusCode};
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map> registerUser(String fullName, String email, String password,
      String studentId, String studentPassword) async {
    bool status = false;
    String role = "user";

    try {
      Uri url = Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.register}');
      String body = jsonEncode({
        "fullName": fullName,
        "email": email,
        "password": password,
        "studentId": studentId,
        "studentPassword": studentPassword,
        "status": status,
        "role": role
      });
      final responce = await http
          .post(url, body: body, headers: {"content-type": "application/json"});
      return {'body': responce.body, 'statusCode': responce.statusCode};
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map> verifyEmail(String email, String code) async {
    try {
      Uri url = Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.verifyEmail}');
      String body = jsonEncode({"email": email, "code": code});
      final responce = await http
          .post(url, body: body, headers: {"content-type": "application/json"});
      return {'body': responce.body, 'statusCode': responce.statusCode};
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map> login(String email, String password) async {
    try {
      Uri url = Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.login}');
      String body = jsonEncode({"email": email, "password": password});
      final responce = await http
          .post(url, body: body, headers: {"content-type": "application/json"});
      return {'body': responce.body, 'statusCode': responce.statusCode};
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map> getUserDetails(String token) async {
    try {
      Uri url = Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.getAllUsers}');
      Map<String, String> header = {
        'Authorization': 'Bearer $token ',
        'Content-Type': 'application/json',
      };

      final responce = await http.get(url, headers: header);

      if (responce.statusCode == 200) {
        return {'body': responce.body, 'success': true};
      } else {
        return {'body': responce.body, 'success': false};
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map> changeRole(String newRole, String userId, String token) async {
    try {
      Uri url = Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.changeRole}');
      Map<String, String> header = {
        'Authorization': 'Bearer $token ',
        'Content-Type': 'application/json',
      };

      String body = jsonEncode({'newRole': newRole, 'userId': userId});

      final responce = await http.put(url, headers: header, body: body);

      if (responce.statusCode == 200) {
        return {'body': responce.body, 'success': true};
      } else {
        return {'body': responce.body, 'success': false};
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map> getProfle(String token) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token ',
        'Content-Type': 'application/json',
      };
      Uri url = Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.getProfile}');
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return {'success': true, 'body': body};
      } else {
        return {
          'success': false,
          'message': 'Failed to get profile',
          'body': response.body
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to get profile'};
    }
  }

  /* {
  "fullName": "John Doe",
  "fieldOfStudy": "Computer Science",
  "bio": "This is a bio",
  "profilePicture": "http://example.com/profile.jpg"
} */

  Future<Map> createProfile(String token, String fullName, String fieldOfStudy, String bio, String profilePicture ) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token ',
        'Content-Type': 'application/json',
      };

      String body = jsonEncode({
        'fullName': fullName,
        'fieldOfStudy': fieldOfStudy,
        'bio': bio,
        'profilePicture': profilePicture
      });
      Uri url = Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.createProfile}');
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);
        return {'success': true, 'body': body};
      } else {
        return {
          'success': false,
          'message': 'Failed to create profile',
          'body': response.body
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to create profile'};
    }
  }
}
