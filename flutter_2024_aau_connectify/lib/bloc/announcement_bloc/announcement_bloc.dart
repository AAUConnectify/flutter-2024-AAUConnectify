import 'package:equatable/equatable.dart';
import 'package:flutter_2024_aau_connectify/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_2024_aau_connectify/models/announcement_mode.dart';
import 'package:flutter_2024_aau_connectify/repository/announcement_repository.dart';
import 'package:flutter_2024_aau_connectify/repository/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part './announcement_event.dart';
part './announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AnnouncementRepository announcementRepository;

  AnnouncementBloc({required this.announcementRepository})
      : super(AnnouncementInitial()) {
    on<FetchAnnouncements>(_getannouncement);
    on<CreateAnnouncementEvent>(_onCreateAnnouncement);
    on<UpdateAnnouncement>(_onUpdateAnnouncement);
    on<DeleteAnnouncement>(_onDeleteAnnouncement);
    on<FetchAnnouncementById>(_getannouncementById);
  }

  Future<void> _getannouncement(
      FetchAnnouncements event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementLoading());
    try {
      final token = await _getToken();
      if (token == null) {
        print('no token found');
        emit(NoTokenFound());
        return;
      }
      TokenM tokenM = TokenM(token);
      final isExpired = tokenM.isExpired();
      if (isExpired) {
        print('token expired');
        emit(NoTokenFound());
        return;
      }
      

      final announcements = await announcementRepository.getAnnouncements(
          event.page, event.limit, token);

      if (announcements.isEmpty) {
        emit(AnnouncementEmpty());
      } else {
        emit(AnnouncementsLoaded(announcements));
      }
    } catch (e) {
      emit(AnnouncementOperationFailure(e.toString()));
    }
  }

  Future<void> _getannouncementById(
      FetchAnnouncementById event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementLoading());
    try {
      final token = await _getToken();
      if (token == null) {
        emit(NoTokenFound());
        return;
      }

      final announcements =
          await announcementRepository.getAnnouncementById(event.id, token);
      emit((SingleAnnouncementLoaded(announcements)));
    } catch (e) {
      emit(AnnouncementOperationFailure(e.toString()));
    }
  }

  Future<void> _onCreateAnnouncement(
      CreateAnnouncementEvent event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementLoading());
    try {
      final token = await _getToken();
      if (token == null) {
        emit(NoTokenFound());
        return;
      }
      TokenM tokenM = TokenM(token);
      final isExpired = tokenM.isExpired();
      if (isExpired) {
        emit(NoTokenFound());
        return;
      }
      final response = await announcementRepository.createAnnouncement(
          event.title,
          event.content,
          event.category,
          event.summary,
          event.date,
          event.image,
          event.tag,
          token);
      if (response['success']) {
        emit(AnnouncementOperationSuccess());
      } else if (response['logout']) {
        emit(NoTokenFound());
      } else {
        emit(const AnnouncementOperationFailure(
            'Failed to create announcement'));
      } 
    } catch (e) {
      emit(AnnouncementOperationFailure(e.toString()));
    }
  }

  Future<void> _onUpdateAnnouncement(
      UpdateAnnouncement event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementLoading());
    try {
      final token = await _getToken();
      if (token == null  ) {
        emit(NoTokenFound());
        return;
      }
      TokenM tokenM = TokenM(token);
      final isExpired = tokenM.isExpired();
      if (isExpired) {
        emit(NoTokenFound());
        return;
      }
      final response = await announcementRepository.updateAnnouncementById(
          event.id,
          event.title,
          event.content,
          event.category,
          event.summary,
          event.date,
          event.image,
          event.tag,
          token);
       if (response['success']) {
        emit(AnnouncementOperationSuccess());
      } else if (response['logout']) {
        emit(NoTokenFound());
      } else {
        emit(const AnnouncementOperationFailure(
            'Failed to update announcement'));
      }
    } catch (e) {
      emit(AnnouncementOperationFailure(e.toString()));
    }
  }

  Future<void> _onDeleteAnnouncement(
      DeleteAnnouncement event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementLoading());
    try {
      final token = await _getToken();
      if (token == null) {
        emit(NoTokenFound());
        return;
      }
      TokenM tokenM = TokenM(token);
      final isExpired = tokenM.isExpired();
      if (isExpired) {
        emit(NoTokenFound());
        return;
      }
      final response =
          await announcementRepository.deleteAnnouncementById(event.id, token);
      if (response['success']) {
        emit(AnnouncementOperationSuccess());
      } else if (response['logout']) {
        emit(NoTokenFound());
      } else {
        emit(const AnnouncementOperationFailure(
            'Failed to delete announcement'));
      }
    } catch (e) {
      emit(AnnouncementOperationFailure(e.toString()));
    }
  }
 

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // a I need a function that acts as a loggger for the bloc
  @override
  void onEvent(AnnouncementEvent event) {
    print('$event is the event that was called');
    super.onEvent(event);
  }
  
}
