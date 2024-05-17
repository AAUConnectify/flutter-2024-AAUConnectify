import 'dart:convert';

import 'package:flutter_2024_aau_connectify/data_providers/comment_data_provider.dart';
import 'package:flutter_2024_aau_connectify/models/comment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentRepository {
  final CommentDataProvider dataProvider;

  CommentRepository({required this.dataProvider});

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future<Map> fetchComments(String announcementId) async {
    final token = await _getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token not found'};
    }
    final response = await dataProvider.fetchComments(announcementId, token);
    if (response['success']) {
      final commentsData = jsonDecode(response['body']);
      List<Comment> comments = [];
      for (var comment in commentsData) {
        comments.add(Comment.fromMap(comment));
      }

      return {'success': true, 'comment': comments};
    } else {
      return {'success': false, 'message': response['message']};
    }
  }

  Future<Map> createComment(String content, String announcementId) async {
    final token = await _getToken();
    final userId = await _getUserId();
    if (token == null || userId == null) {
      return {'success': false, 'message': 'Token or user ID not found'};
    }
    final response = await dataProvider.createComment(
        content, token, userId, announcementId);
    if (response['success']) {
      return {'success': true, 'comment': jsonDecode(response['body'])};
    } else {
      return {'success': false, 'message': response['message']};
    }
  }

  Future<Map> updateComment(
      String commentId, String content, String announcementId) async {
    final token = await _getToken();
    final userId = await _getUserId();
    if (token == null || userId == null) {
      return {'success': false, 'message': 'Token or user ID not found'};
    }
    final response = await dataProvider.updateComment(
        commentId, content, token, userId, announcementId);
    if (response['success']) {
      final commentsData = jsonDecode(response['body']);
      List<Comment> comments = [];
      for (var comment in commentsData) {
        comments.add(Comment.fromMap(comment));
      }

      return {'success': true, 'comment': comments};
    } else {
      return {'success': false, 'message': response['message']};
    }
  }

  Future<Map> deleteComment(String commentId) async {
    final token = await _getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token not found'};
    }
    final response = await dataProvider.deleteComment(commentId, token);
    if (response['success']) {
      return {'success': true, 'message': 'Comment deleted successfully'};
    } else {
      return {'success': false, 'message': response['message']};
    }
  }

  Future<Map> fetchCommentById(String commentId) async {
    final token = await _getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token not found'};
    }
    final response = await dataProvider.fetchCommentById(commentId, token);
    final commentData = jsonDecode(response['body']);

    if (response['success']) {
      return {'success': true, 'comment': Comment.fromMap(commentData)};
    } else {
      return {'success': false, 'message': response['message']};
    }
  }
}
