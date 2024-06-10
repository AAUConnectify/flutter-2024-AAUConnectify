part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class AdminDemoteSucces extends UserState {}

final class AdminDemoteFailure extends UserState {
  final String error;

  const AdminDemoteFailure(this.error);
}

final class UserPromoteSucces extends UserState {}

final class UserPromoteFailure extends UserState {
  final String error;

  const UserPromoteFailure( this.error);
}

final class UserPromoteLoding extends UserState {}

final class AdminPromoteLoding extends UserState {}

final class NoTokenFound extends UserState {}
