
part of 'announcement_bloc.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();

  @override
  List<Object> get props => [];
}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementsLoaded extends AnnouncementState {
  final List<Announcement> announcements;

  const AnnouncementsLoaded(this.announcements);

  @override
  List<Object> get props => [announcements];
}

class AnnouncementEmpty extends AnnouncementState {}

class AnnouncementOperationSuccess extends AnnouncementState {}
class NoTokenFound extends AnnouncementState {}

class AnnouncementOperationFailure extends AnnouncementState {
  final String error;

  const AnnouncementOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}

class SingleAnnouncementLoaded extends AnnouncementState {
  final Announcement announcement;

  const SingleAnnouncementLoaded(this.announcement);

  @override
  List<Object> get props => [announcement];
}