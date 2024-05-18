import 'dart:convert';

import 'package:flutter_2024_aau_connectify/infrastructure/data_providers/comment_data_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CommentDataProvider', () {
    test('fetchComments should return a valid response', () async {
      // Arrange
      final commentDataProvider = CommentDataProvider();
      const announcementId = '6659c2aa873a77f0ed228a6e';
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZ1YWQubW9oYW1tZWRAYTJzdi5vcmciLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTcxODYxMTczOSwiZXhwIjoxNzE4NjE1MzM5fQ.H1P9EdGzi_HmThYfMALg05pR8Pxapi1p7xmaILxJYew';

      // Act
      final response = await commentDataProvider.fetchComments(announcementId, token);
      print(response);

      // Assert
      expect(response, isNotNull);
      
      // Add more assertions based on the expected response
    });

    test('createComment should return a valid response', () async {
      // Arrange
      final commentDataProvider = CommentDataProvider();
      const content = 'This is a HELO     NUMBER 2 world comment';
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZ1YWQubW9oYW1tZWRAYTJzdi5vcmciLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTcxODYxMTczOSwiZXhwIjoxNzE4NjE1MzM5fQ.H1P9EdGzi_HmThYfMALg05pR8Pxapi1p7xmaILxJYew';
      const userId = '6654898984d7632cf314011e';
      const announcementId = '6659c2aa873a77f0ed228a6e';

      // Act
      final response = await commentDataProvider.createComment(content, token, userId, announcementId);
      print(response);

      // Assert
      expect(response, isNotNull);

      // Add more assertions based on the expected response
    });

    test('updateComment should return a valid response', () async {
      // Arrange
      final commentDataProvider = CommentDataProvider();
      const commentId = 'sample_comment_id';
      const content = 'Updated comment content';
      const token = ' eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZ1YWQubW9oYW1tZWRAYTJzdi5vcmciLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTcxODYwNjY4MSwiZXhwIjoxNzE4NjEwMjgxfQ.5ASTL0vEvJ1JeEPJBfLnpWVytiRewJtWXUrE4BZeJEg';
      const userId = 'sample_user_id';
      const announcementId = 'sample_announcement_id';

      // Act
      final response = await commentDataProvider.updateComment(commentId, content, token, userId, announcementId);
      print(response);
      // Assert
      expect(response, isNotNull);
      
      // Add more assertions based on the expected response
    });

    test('deleteComment should return a valid response', () async {
      // Arrange
      final commentDataProvider = CommentDataProvider();
      const commentId = 'sample_comment_id';
      const token = ' eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZ1YWQubW9oYW1tZWRAYTJzdi5vcmciLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTcxODYwNjY4MSwiZXhwIjoxNzE4NjEwMjgxfQ.5ASTL0vEvJ1JeEPJBfLnpWVytiRewJtWXUrE4BZeJEg';

      // Act
      final response = await commentDataProvider.deleteComment(commentId, token);
      print(response);
      // Assert
      expect(response, isNotNull);
      
      // Add more assertions based on the expected response
    });

    test('fetchCommentById should return a valid response', () async {
      // Arrange
      final commentDataProvider = CommentDataProvider();
      const commentId = '66603c7cbc5e647c8f005cc7';
      const token = ' eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZ1YWQubW9oYW1tZWRAYTJzdi5vcmciLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MTc1ODI5NTYsImV4cCI6MTcxNzU4NjU1Nn0._-9vJ_lXNMfco9dgPTZiqE7f8Qu_usTLuoVXKhxTtE0';

      // Act
      final response = await commentDataProvider.fetchCommentById(commentId, token);
      print(response);
      // Assert
      expect(response, isNotNull);
      // Add more assertions based on the expected response
    });
  });
}
