part of 'announcement_bloc.dart';

abstract class AnnouncementEvent extends Equatable {
  const AnnouncementEvent();

  @override
  List<Object> get props => [];
}

class FetchAnnouncements extends AnnouncementEvent {
  final int page;
  final int limit;

  const FetchAnnouncements(this.page, this.limit);

  @override
  List<Object> get props => [page, limit];
}

class CreateAnnouncement extends AnnouncementEvent {
  final String title;
  final String content;
  final String category;
  final String summary;
  final String date;
  final String image;
  final String tag;

  const CreateAnnouncement({
    required this.title,
    required this.content,
    required this.category,
    required this.summary,
    required this.date,
    required this.image,
    required this.tag,
  });

  @override
  List<Object> get props => [title, content, category, summary, date, image, tag];
}

class UpdateAnnouncement extends AnnouncementEvent {
  final String id;
  final String title;
  final String content;
  final String category;
  final String summary;
  final String date;
  final String image;
  final String tag;

  const UpdateAnnouncement({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.summary,
    required this.date,
    required this.image,
    required this.tag,
  });

  @override
  List<Object> get props => [id, title, content, category, summary, date, image, tag];
}

class DeleteAnnouncement extends AnnouncementEvent {
  final String id;

  const DeleteAnnouncement(this.id);

  @override
  List<Object> get props => [id];
}

class RefreshAnnouncements extends AnnouncementEvent {
  const RefreshAnnouncements();
}

class FetchAnnouncementById extends AnnouncementEvent {
  final String id;

  const FetchAnnouncementById(  {required this.id});

  @override
  List<Object> get props => [id];
}
