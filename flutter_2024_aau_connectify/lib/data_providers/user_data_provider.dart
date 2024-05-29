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
}
