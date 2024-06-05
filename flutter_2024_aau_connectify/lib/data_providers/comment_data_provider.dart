import 'dart:convert';
import 'package:flutter_2024_aau_connectify/secret.dart';
import 'package:http/http.dart' as http;

class CommentDataProvider {
  Future<Map> fetchComments(String announcementId, String token) async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json',};
      String api = '${APIEndpoints.baseUrl}${APIEndpoints.getCommentsByAnnouncementId}?announcementId=$announcementId';
      Uri url = Uri.parse(api);
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return {'success': true, 'body': response.body};
      } else {
        return {
          'success': false,
          'message': 'Failed to load comments',
          'body': response.body
        };
      }
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }

  Future<Map> createComment(String content, String token, String userId, String announcementId) async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json',};
      String api = '${APIEndpoints.baseUrl}${APIEndpoints.createComment}';
      final body = jsonEncode({
        "content": content,
        "userId": userId,
        "announcementId": announcementId
      });

      Uri url = Uri.parse(api);
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        return {'success': true, 'body': response.body};
      } else {
        return {
          'success': false,
          'message': 'Failed to create comment',
          'body': response.body
        };
      }
    } catch (e) {
      throw Exception('Failed to create comment: $e');
    }
  }

  Future<Map> updateComment(String commentId, String content, String token, String userId, String announcementId) async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json',};
      String api = '${APIEndpoints.baseUrl}${APIEndpoints.updateComment}/$commentId';
      final body = jsonEncode({
        "content": content,
        "userId": userId,
        "announcementId": announcementId
      });

      Uri url = Uri.parse(api);
      final response = await http.patch(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return {'success': true, 'body': response.body};
      } else {
        return {
          'success': false,
          'message': 'Failed to update comment',
          'body': response.body
        };
      }
    } catch (e) {
      throw Exception('Failed to update comment: $e');
    }
  }

  Future<Map> deleteComment(String commentId, String token) async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json',};
      String api = '${APIEndpoints.baseUrl}${APIEndpoints.deleteComment}/$commentId';
      Uri url = Uri.parse(api);
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        return {'success': true, 'body': response.body};
      } else {
        return {
          'success': false,
          'message': 'Failed to delete comment',
          'body': response.body
        };
      }
    } catch (e) {
      throw Exception('Failed to delete comment: $e');
    }
  }

  Future<Map> fetchCommentById(String commentId, String token) async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json',};
      String api = '${APIEndpoints.baseUrl}${APIEndpoints.getCommentById}/$commentId';
      Uri url = Uri.parse(api);
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return {'success': true, 'body': response.body};
      } else {
        return {
          'success': false,
          'message': 'Failed to load comment',
          'body': response.body
        };
      }
    } catch (e) {
      throw Exception('Failed to load comment: $e');
    }
  }
}
