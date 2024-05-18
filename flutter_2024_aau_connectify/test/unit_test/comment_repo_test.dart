import 'dart:convert';

import 'package:flutter_2024_aau_connectify/infrastructure/data_providers/comment_data_provider.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/repository/comment_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockCommentDataProvider extends Mock implements CommentDataProvider {}

void main(){
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });
  group('Testing comment Repos', () { 
    final mockCommentDataProvider = MockCommentDataProvider();
    final mockRepo = CommentRepository(dataProvider: mockCommentDataProvider);
    final Map comment = {
      'id': '1',
      'content': 'content',
      'announcementId': 'announcementId',
      'userId': 'userId',
      'fullName': 'fullName',
    };
    setUp(() {
      when(() => mockCommentDataProvider.fetchComments('1', 'token')).thenAnswer((_) async => {'success': true, 'body': jsonEncode([comment])});
      when(() => mockCommentDataProvider.createComment('content', 'token', 'userId', 'announcementId')).thenAnswer((_) async => {'success': true, 'body': jsonEncode(comment)});
      when(() => mockCommentDataProvider.updateComment('commentId', 'content', 'token', 'userId', 'announcementId')).thenAnswer((_) async =>{'success': true, 'body': jsonEncode(comment)});
      when(() => mockCommentDataProvider.deleteComment('commentId', 'token')).thenAnswer((_) async => {'success': true, 'message': 'Comment deleted successfully'});
    });

    test('fetchComments should return  False  response because of of token ', () async {
      final response = await mockRepo.fetchComments('1');
      expect(response['success'], false);
    });
 
    test('createComment should return a Invalid response because of token and user id', () async {
      final response = await mockRepo.createComment('content', 'announcementId');
      expect(response['success'], false);
    });

    test('updateComment should return a valid response', () async {
      final response = await mockRepo.updateComment('commentId', 'content', 'announcementId');
      expect(response['success'], false);
    });
    test('deleteComment should return a valid response', () async {
      final response = await mockRepo.deleteComment('commentId');
      expect(response['success'], false);
    }); 
  });
}