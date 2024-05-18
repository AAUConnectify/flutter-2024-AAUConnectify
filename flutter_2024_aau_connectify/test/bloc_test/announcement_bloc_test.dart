import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_2024_aau_connectify/application/announcement/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/Domain/announcement_mode.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/repository/announcement_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnnouncementRepository extends Mock
    implements AnnouncementRepository {}

void main() {
  group('AnnouncementBloc', () {
    final announRepoMock = MockAnnouncementRepository();
    final List<Announcement> announcements = [
      Announcement(
        id: '1',
        title: 'title',
        content: 'content',
        category: 'category',
        summary: 'summary',
        date: 'date',
        image: 'image',
        tag: 'tag',
      )
    ];
    final Map announcement = {
      'title': 'title',
      'content': 'content',
      'category': 'category',
      'summary': 'summary',
      'date': 'date',
      'image': 'image',
      'tag': 'tag',
      'token': 'token'
    };
    blocTest<AnnouncementBloc, AnnouncementState>(
      'Check  when FetchAnnouncements is added',
      build: () => AnnouncementBloc(announcementRepository: announRepoMock),
      setUp: () {
        when(() => announRepoMock.getAnnouncements(1, 1, 'token'))
            .thenAnswer((_) async => announcements);
      },
      act: (bloc) => bloc.add(const FetchAnnouncements(1, 1)),
      expect: () => <AnnouncementState>[
        AnnouncementLoading(),
        const AnnouncementOperationFailure('Failed to load announcements')
      ],
    );

    blocTest<AnnouncementBloc, AnnouncementState>(
      'Check  when FetchAnnouncements is added',
      build: () => AnnouncementBloc(announcementRepository: announRepoMock),
      setUp: () {
        when(() => announRepoMock.createAnnouncement(
            announcement['title'],
            announcement['content'],
            announcement['category'],
            announcement['summary'],
            announcement['date'],
            announcement['image'],
            announcement['tag'],
            announcement['token'])).thenAnswer((_) async => announcement);
      },
      act: (bloc) => bloc.add(CreateAnnouncementEvent(
        title: announcement['title'],
        content: announcement['content'],
        summary: announcement['summary'],
        date: announcement['date'],
        image: announcement['image'],
        tag: announcement['tag'],
      )),
      expect: () => <AnnouncementState>[
        AnnouncementLoading(),
        const AnnouncementOperationFailure('Failed to create announcement')
      ],
    );

    blocTest<AnnouncementBloc, AnnouncementState>(
        'Check when FetchAnnouncementById is added',
        build: () => AnnouncementBloc(announcementRepository: announRepoMock),
        setUp: () {
          when(() => announRepoMock.getAnnouncementById('1', 'token'))
              .thenAnswer((_) async => announcements[0]);
        },
        act: (bloc) => bloc.add(const FetchAnnouncementById(id: '1')),
        expect: () => <AnnouncementState>[
              AnnouncementLoading(),
              const AnnouncementOperationFailure('Failed to load announcements')
        ]);
  });
}
