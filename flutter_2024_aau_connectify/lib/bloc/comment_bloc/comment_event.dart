part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}


class FetchComments extends CommentEvent {
  final String announcementId;

  const FetchComments(this.announcementId);

  @override
  List<Object> get props => [announcementId];
}

class CreateComment extends CommentEvent {
  final String content;
  final String announcementId;

  const CreateComment(this.content, this.announcementId);

  @override
  List<Object> get props => [content, announcementId];
}

class UpdateComment extends CommentEvent {
  final String commentId;
  final String content;
  final String announcementId;

  const UpdateComment(this.commentId, this.content, this.announcementId);

  @override
  List<Object> get props => [commentId, content, announcementId];
}

class DeleteComment extends CommentEvent {
  final String commentId;

  const DeleteComment(this.commentId);

  @override
  List<Object> get props => [commentId];
}

class FetchCommentById extends CommentEvent {
  final String commentId;

  const FetchCommentById(this.commentId);

  @override
  List<Object> get props => [commentId];
}
