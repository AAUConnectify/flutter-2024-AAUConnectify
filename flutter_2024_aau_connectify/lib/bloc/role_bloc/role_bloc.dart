import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_2024_aau_connectify/repository/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'role_event.dart';
part 'role_state.dart';

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_id');
}

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(RoleInitial()) {
    on<RoleStatus>((event, emit) async {
      emit(RoleLoading());
      String? token = await getToken();
      String? userId = await getUserId();
      if (token == null) {
        emit(NoTokenFound());
        return;
      }

      TokenM tokenM = TokenM(token);

      final isExpired = tokenM.isExpired();
      final role = tokenM.getRole();
      if (isExpired) {
        emit(NoTokenFound());
        return;
      }
      emit(UserData(role, isExpired, userId!));
    });
  }
  void onEvent(RoleEvent event) {
    print('$event is the event that was called');
    super.onEvent(event);
  }
}
