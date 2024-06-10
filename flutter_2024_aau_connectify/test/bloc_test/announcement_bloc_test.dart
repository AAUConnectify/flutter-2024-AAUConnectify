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
      expect: () =>   [AnnouncementLoading(),
            const AnnouncementOperationFailure("""Binding has not yet been initialized.  
          The "instance" getter on the ServicesBinding binding mixin is only available once that binding has been initialized.  
          Typically, this is done by calling "WidgetsFlutterBinding.ensureInitialized()" or "runApp()" (the latter calls the former). Typically this call is done in the "void main()" method. The "ensureInitialized" method is idempotent; calling it multiple times is not harmful. After calling that method, the "instance" getter will return the binding.  
          In a test, one can call "TestWidgetsFlutterBinding.ensureInitialized()" as the first line in the test's "main()" method to initialize the binding.  
          If ServicesBinding is a custom binding mixin, there must also be a custom binding class, like WidgetsFlutterBinding, but that mixes in the selected binding, and that is the class that must be constructed before using the "instance" getter.""")
          ] ,
    );
  });
}
