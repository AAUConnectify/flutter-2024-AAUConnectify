
// authentication_event.dart
part of 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String email;
  final String password;

  const LoggedIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoggedOut extends AuthenticationEvent {}

class Registered extends AuthenticationEvent {
  final String fullName;
  final String email;
  final String password;
  final String studentId;
  final String studentPassword;

  

  const Registered({
    required this.fullName,
    required this.email,
    required this.password,
    required this.studentId,
    required this.studentPassword,
  });

  @override
  List<Object> get props => [fullName, email, password, studentId, studentPassword];
}

class VerifyEmail extends AuthenticationEvent {
  final String email;
  final String code;

  const VerifyEmail({required this.email, required this.code});

  @override
  List<Object> get props => [email, code];
}

class CheckStudent extends AuthenticationEvent {
  final String studentId;
  final String studentPassword;

  const CheckStudent({required this.studentId, required this.studentPassword});

  @override
  List<Object> get props => [studentId, studentPassword];
}

