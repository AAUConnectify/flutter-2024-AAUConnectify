part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

// State when the app starts and is unauthenticated
class AuthenticationUnauthenticated extends AuthenticationState {}

// State specifically after student verification but before account creation
class AuthenticationStudentVerified extends AuthenticationState {}

// State specifically after account creation but before email verification
class AuthenticationAccountCreated extends AuthenticationState {}

// State specifically after email verification but before login
class AuthenticationEmailVerified extends AuthenticationState {}

// State when authentication is complete
class AuthenticationAuthenticated extends AuthenticationState {
  final String token;

  const AuthenticationAuthenticated({required this.token});

  @override
  List<Object> get props => [token];
}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  const AuthenticationFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class UserDetailLoaded extends AuthenticationState{
  final List<User> user;
  const UserDetailLoaded({required this.user}); 
}

class UserLoadFailure extends AuthenticationState{
  final String error;
  const UserLoadFailure({required this.error});
  @override
  List<Object> get props => [error];
}
class UserLoading extends AuthenticationState{}