import 'package:equatable/equatable.dart';
import 'package:flutter_2024_aau_connectify/models/user_model.dart';
import 'package:flutter_2024_aau_connectify/repository/token.dart';
import 'package:flutter_2024_aau_connectify/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}
Future<String?> getRole() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('role');
}

Future<void> saveToken(String token, Profile user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
  await prefs.setString('user_id', user.user);
}
Future<void> saveTokenOnly(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<Registered>(_onRegistered);
    on<VerifyEmail>(_onVerifyEmail);
    on<CheckStudent>(_onCheckStudent);
    on<GetUserDetails>(_onGetUserDetails);
    on<CreateProfile>(_createProfile);
  }

  Future<void> _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    final token = await getToken();
    if (token != null) {
      emit(AuthenticationAuthenticated(token: token));
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final response = await userRepository.login(event.email, event.password);
      print('response is $response');
      if (response['success']) {
        final profile = await userRepository.getProfile(response['token']);
                print('profile is $profile');

        Profile user = Profile.fromMap(profile['user']['profile']);
        if (profile['success']) {
          await saveToken(response['token' ], user);
        }
        emit(AuthenticationAuthenticated(token: response['token']));
      } else {
        emit(const AuthenticationFailure(error: 'Login failed'));
      }
    } catch (e) {
      emit(AuthenticationFailure(error: e.toString()));
    }
  }

  Future<void> _onLoggedOut(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    await removeToken();
    emit(AuthenticationUnauthenticated());
  }

  Future<void> _onRegistered(
      Registered event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final success = await userRepository.registerUser(
        event.fullName,
        event.email,
        event.password,
        event.studentId,
        event.studentPassword,
      );
      if (success) {
        emit(AuthenticationAccountCreated());
      } else {
        emit(const AuthenticationFailure(error: 'Registration failed'));
      }
    } catch (e) {
      emit(AuthenticationFailure(error: e.toString()));
    }
  }

  Future<void> _onVerifyEmail(
      VerifyEmail event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final success =
          await userRepository.verifyUserEmail(event.email, event.code);
      if (success['success']) {

        await saveTokenOnly(success['body']['token']);
        emit(AuthenticationEmailVerified());
        return; 
      } else {
        emit(const AuthenticationFailure(error: 'Email verification failed'));
      }
    } catch (e) {
      emit(AuthenticationFailure(error: e.toString()));
    }
  }

  Future<void> _onCheckStudent(
      CheckStudent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final exists = await userRepository.checkStudent(
          event.studentId, event.studentPassword);
      if (exists) {
        emit(AuthenticationStudentVerified());
      } else {
        emit(const AuthenticationFailure(error: 'Student check failed'));
      }
    } catch (e) {
      emit(AuthenticationFailure(error: e.toString()));
    }
  }

  Future<void> _onGetUserDetails(
      GetUserDetails event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final token = await getToken();
      if (token == null) {
        emit(AuthenticationUnauthenticated());
        return;
      }

      final user = await userRepository.getUserDetails(token);
      if (user['success'] == false) {
        emit(const UserLoadFailure(error: 'Failed to get user details'));
        return;
      }
      if (user['success'] == false) {
        emit(const UserLoadFailure(error: 'Failed to get user details'));
        return;
      }
      final data = user['user']['users'];
      final List<User> userData = [];
      for (var value in data) {
        userData.add(User.fromMap(value));
      }
      emit(UserDetailLoaded(user: userData));
    } catch (e) {
      emit(UserLoadFailure(error: e.toString()));
    }
  }
  Future<void> _createProfile(
      CreateProfile event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final token = await getToken();
      if (token == null) {
        emit(AuthenticationUnauthenticated());
        return;
      }

      final user = await userRepository.createProfile(token, event.fullName, event.fieldOfStudy, event.bio, event.profilePicture);
      if (user['success'] == false) {
        emit(const UserLoadFailure(error: 'Failed to create profile'));
        return;
      }    
      emit(AuthenticationEmailVerified());
    } catch (e) {
      emit(UserLoadFailure(error: e.toString()));
    }
  }
  void onEvent(AuthenticationEvent event) {
    print('$event is the event that was called');
    super.onEvent(event);
  }
}
