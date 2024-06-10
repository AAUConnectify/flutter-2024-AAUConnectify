import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_2024_aau_connectify/secret.dart';

class AnnouncementDataProvider {
  Future<Map> getAnnouncements(int page, int limit, String token) async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      String api =
          '${APIEndpoints.baseUrl}${APIEndpoints.getAnnouncements}?page=$page&limit=$limit';
      Uri url = Uri.parse(api);
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return {'success': true, 'body': response.body};
      } else {
        return {
          'success': false,
          'message': 'Failed to load announcements',
          'body': response.body
        };
      }
    } catch (e) {
      throw Exception('Failed to load announcements: $e');
    }
  }
/*
{
  "title": "string",
  "content": "string",
  "category": "string",
  "summary": "string",
  "date": "2024-05-30T15:07:31.394Z",
  "image": "string",
  "tag": "string"
}*/

  Future<Map> createAnnouncement(
      String title,
      String content,
      String category,
      String summary,
      String date,
      String image,
      String tag,
      String token) async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json',};
      Uri url = Uri.parse(
          '${APIEndpoints.baseUrl}${APIEndpoints.createAnnouncement}');
       
      String body = jsonEncode({
        "title": title,
        "content": content,
        "category": category,
        "summary": summary,
        "date": date,
        "image": image,
        "tag": tag
      });
      final response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 201) {
        return {'success': true, 'body': response.body};
      } else {
        return {
          'success': false,
          'message': 'Failed to create announcement',
          'body': response.body
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to create announcement'};
    }
  }

  Future<Map> getAnnouncementById(String id, String token) async {
    try {
      /* Map<String, String> headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'}; */
      Uri url = Uri.parse(
          '${APIEndpoints.baseUrl}${APIEndpoints.getAnnouncementById}/$id');
      final response = await http.get(url,);
      if (response.statusCode == 200) {
        return {'success': true, 'body': response.body};
      } else {
        return {
          'success': false,
          'message': 'Failed to load announcement',
          'body': response.body
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to load announcement'};
      }
  }

  Future<Map> updateAnnouncementById(
      String id,
      String title,
      String content,
      String category,
      String summary,
      String date,
      String image,
      String tag,
      String token) async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
      Uri url = Uri.parse(
          '${APIEndpoints.baseUrl}${APIEndpoints.updateAnnouncement}/$id');
      String body = jsonEncode({
        "title": title,
        "content": content,
        "category": category,
        "summary": summary,
        "date": date,
        "image": image,
        "tag": tag
      });
      final response = await http.patch(url, body: body, headers: headers);
      if (response.statusCode == 200) {
        return {'success': true, 'body': response.body};
      } else {
        return {
          'success': false,
          'message': 'Failed to update announcement',
          'body': response.body
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to update announcement'};
    }
  }

  Future<Map> deleteAnnouncementById(String id, String token) async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token ', 'Content-Type': 'application/json',};
      Uri url = Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.deleteAnnouncement}/$id');
      final response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        return {'success': true, 'body': response.body};
      } else {
        return {
          'success': false,
          'message': 'Failed to delete announcement',
          'body': response.body
        };
        
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to delete announcement'};
    }
  }
}
