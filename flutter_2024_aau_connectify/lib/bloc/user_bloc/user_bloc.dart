import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_2024_aau_connectify/repository/token.dart';
import 'package:flutter_2024_aau_connectify/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepo;
  UserBloc(this.userRepo) : super(UserInitial()) {
    on<AdminDemote>(_adminDemote);
    on<UserPromote>(_userPromote);
    on<GetRole>(_getRole);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> _adminDemote(AdminDemote event, Emitter<UserState> emit) async {
    emit(AdminPromoteLoding());
    try {
      final token = await _getToken();
      if (token == null) {
        emit(NoTokenFound());
        return;
      }
      final response =
          await userRepo.changeRole(event.newRole, event.userID, token);
      if (response['success']) {
        emit(AdminDemoteSucces());
        return;
      }
      emit(const AdminDemoteFailure('Failed to change role'));
    } catch (e) {
      emit(const AdminDemoteFailure('Failed to change role'));
    }
  }

  Future<void> _userPromote(UserPromote event, Emitter<UserState> emit) async {
    emit(UserPromoteLoding());
    try {
      final token = await _getToken();
      if (token == null) {
        emit(NoTokenFound());
        return;
      }
      final response =
          await userRepo.changeRole(event.newRole, event.userID, token);
      if (response['success']) {
        emit(UserPromoteSucces());
        return;
      }
      emit(const UserPromoteFailure('Failed to change role'));
    } catch (e) {
      emit(const UserPromoteFailure('Failed to change role'));
    }
  }

  Future<void> _getRole(GetRole event, Emitter<UserState> emit) async {
    emit(UserPromoteLoding());
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
      final role = tokenM.getRole();
      emit(const UserPromoteFailure('Failed to change role'));
    } catch (e) {
      emit(const UserPromoteFailure('Failed to change role'));
    }
  }
  void onEvent(UserEvent event) {
    print('$event is the event that was called');
    super.onEvent(event);
  }
}
