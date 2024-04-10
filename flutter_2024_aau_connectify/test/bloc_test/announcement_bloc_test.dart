import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_2024_aau_connectify/bloc/announcement_bloc/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/data_providers/announcement_data_provider.dart';
import 'package:flutter_2024_aau_connectify/repository/announcement_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnnouncementBloc', () {
    blocTest<AnnouncementBloc, AnnouncementState>(
      'emits [MyState] when MyEvent is added.',
      build: () => AnnouncementBloc(
        announcementRepository: AnnouncementRepository(
          AnnouncementDataProvider(),
        ),
      ),
      act: (bloc) => bloc.add(const FetchAnnouncements(1, 1)),
     
    );
  });
}
