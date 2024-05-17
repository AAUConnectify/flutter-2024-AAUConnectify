part of 'role_bloc.dart';

sealed class RoleState extends Equatable {
  const RoleState();
  
  @override
  List<Object> get props => [];
}

final class RoleInitial extends RoleState {}

final class RoleLoading extends RoleState {}
final class UserData extends RoleState {
  final String role;
  final bool isExpired;
  final String userId;
  const UserData(this.role, this.isExpired, this.userId);
}

final class NoTokenFound extends RoleState {}