part of 'role_bloc.dart';

sealed class RoleEvent extends Equatable {
  const RoleEvent();

  @override
  List<Object> get props => [];
}

final class RoleStatus extends RoleEvent {}

