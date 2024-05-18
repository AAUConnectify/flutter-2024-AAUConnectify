import 'dart:convert';

import 'package:flutter_2024_aau_connectify/Domain/announcement_mode.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/repository/announcement_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/data_providers/announcement_data_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockAnnouncementDataProvider extends Mock
    implements AnnouncementDataProvider {}

void main() {
  group('Testing the announcemen Repo', () {
    final mockAnnouncemenDataProvider = MockAnnouncementDataProvider();
    final mockRepo = AnnouncementRepository(
      mockAnnouncemenDataProvider,
    );
    setUp(() {
      when(() =>
          mockAnnouncemenDataProvider.createAnnouncement(
              'title',
              'content',
              'category',
              'summary',
              'date',
              'image',
              'tag',
              'token')).thenAnswer((_) async =>
          {'success': true, 'message': 'Announcement created successfully'});

      when(() =>
          mockAnnouncemenDataProvider.getAnnouncements(
              1, 1, 'correctToken')).thenAnswer((_) async => {
            'success': true,
            'body': jsonEncode([
              {
                'title': 'title',
                'content': 'content',
                'category': 'category',
                'summary': 'summary',
                'date': 'date',
                'image': 'image',
                'tag': 'tag',
                '_id': 'id'
              }
            ])
          });

      when(() =>
              mockAnnouncemenDataProvider.deleteAnnouncementById('id', 'token'))
          .thenAnswer((_) async => {
                'success': true,
                'message': 'Announcement deleted successfully'
              });
      when(() =>
          mockAnnouncemenDataProvider.deleteAnnouncementById(
              'id', 'wrongToken')).thenAnswer((_) async =>
          {'success': false, 'message': 'Announcement deleted unsuccessfully'});
      when(() => mockAnnouncemenDataProvider.updateAnnouncementById(
                'id',
                'title',
                'content',
                'category',
                'summary',
                'date',
                'image',
                'tag',
                'token',
              ))
          .thenAnswer((_) async => {'success': true, 'body': 'response.body'});
    });

    test('create announcement should return a valid response', () async {
      final response = await mockRepo.createAnnouncement('title', 'content',
          'category', 'summary', 'date', 'image', 'tag', 'token');
      expect(response['success'], true);
    });

    test('get announcements should return a valid response', () async {
      final response = await mockRepo.getAnnouncements(1, 1, 'correctToken');
      final data = Announcement(
        title: 'title',
        content: 'content',
        category: 'category',
        summary: 'summary',
        date: 'date',
        image: 'image',
        tag: 'tag',
        id: 'id',
      );

      expect(response[0], data);
    });

    test('delete announcement should return a valid response', () async {
      final response = await mockRepo.deleteAnnouncementById('id', 'token');
      expect(response['success'], true);
    });
    test('test for the Update', () async {
      final response = await mockRepo.updateAnnouncementById(
        'id',
        'title',
        'content',
        'category',
        'summary',
        'date',
        'image',
        'tag',
        'token',
      );
      expect(response['success'], true);
    });
  });
}
