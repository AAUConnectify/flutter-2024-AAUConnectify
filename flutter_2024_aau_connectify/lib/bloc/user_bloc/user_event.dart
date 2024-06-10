part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class AdminDemote extends UserEvent{
  final String userID;
  final String newRole = 'user';
  const AdminDemote(this.userID);
}

final class UserPromote extends UserEvent{
  final String userID;
  final String newRole = 'admin';
  const UserPromote(this.userID);
}
