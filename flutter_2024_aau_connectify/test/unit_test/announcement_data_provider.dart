import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/data_providers/announcement_data_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockAnnouncementDataProvider extends Mock
    implements AnnouncementDataProvider {}



void main() {
  group('Announcement data provider test ', () {

    
    test('create announcement should return a valid response', () async {
      // Arrange
      final announcementDataProvider = AnnouncementDataProvider();
      const String title = 'this is a title of the announcement';
      const String content = 'This is a new announcement';
      const String category = 'General';
      const String summary = 'This is a summary';
      const String date = '2024-05-30T15:07:31.394Z';
      const String image = 'image';
      const String tag = 'tag';
      const String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZ1YWQubW9oYW1tZWRAYTJzdi5vcmciLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MTcxNTg0MjEsImV4cCI6MTcxNzE2MjAyMX0.MQ5PljuWyob5w1lB2lMsExlL5SUPQ1IZlq3VabviXg4'; // Replace with a valid token

      // Act
      final response = await announcementDataProvider.createAnnouncement(
        title,
        content,
        category,
        summary,
        date,
        image,
        tag,
        token,
      );

      // Assert
      expect(response, isNotNull);
      print(response['body']);
    });

    test('get announcements should return a valid response', () async {
      // Arrange
      final announcementDataProvider = AnnouncementDataProvider();
      const int page = 1;
      const int limit = 10;
      const String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZ1YWQubW9oYW1tZWRAYTJzdi5vcmciLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MTcxNTg0MjEsImV4cCI6MTcxNzE2MjAyMX0.MQ5PljuWyob5w1lB2lMsExlL5SUPQ1IZlq3VabviXg4'; // Replace with a valid token

      // Act
      final response = await announcementDataProvider.getAnnouncements(
        page,
        limit,
        token,
      );
      print(response);

      // Assert
      expect(response, isNotNull);
      expect(response['success'], isTrue);
      expect(response['body'], isNotNull);
    });

    test('update  announcement should return a valid response', () async {
      // Arrange
      final announcementDataProvider = AnnouncementDataProvider();
      const String title = 'New Announcement';
      const String content = 'This is a new announcement';
      const String category = 'General';
      const String summary = 'This is a summary';
      const String date = '2024-05-30T15:07:31.394Z';
      const String image = 'image';
      const String tag = 'tag';
      const String token = 'valid_token_here'; // Replace with a valid token
      const String id = 'valid_id_here'; // Replace with a valid id

      // Act
      final response = await announcementDataProvider.updateAnnouncementById(
        title,
        content,
        category,
        summary,
        date,
        image,
        tag,
        token,
        id,
      );

      // Assert
      expect(response, isNotNull);
      expect(response['success'], isFalse);
      expect(response['body'], isNotNull);
    });

    test('delete announcement should return a valid response', () async {
      // Arrange
      final announcementDataProvider = AnnouncementDataProvider();
      const String id = 'valid_id_here'; // Replace with a valid id
      const String token = 'valid_token_here'; // Replace with a valid token

      // Act
      final response = await announcementDataProvider.deleteAnnouncementById(
        id,
        token,
      );

      // Assert
      expect(response, isNotNull);
      expect(response['success'], isFalse);
      expect(response['body'], isNotNull);
    });

    test('get announcement by id should return a valid response', () async {
      // Arrange
      final announcementDataProvider = AnnouncementDataProvider();
      const String id = '6659c2aa873a77f0ed228a6e'; // Replace with a valid id
      const String token = 'valid_token_here'; // Replace with a valid token

      // Act
      final response = await announcementDataProvider.getAnnouncementById(
        id,
        token,
      );
      print(response);

      // Assert
      expect(response, isNotNull);
      /*    expect(response['success'], isFalse);
      expect(response['body'], isNotNull); */
    });
  });
}
