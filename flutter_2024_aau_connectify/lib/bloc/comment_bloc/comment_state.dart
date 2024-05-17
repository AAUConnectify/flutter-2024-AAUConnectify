part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();
  
  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<Comment> comments;

  const CommentLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentOperationSuccess extends CommentState {
  final Comment comment;

  const CommentOperationSuccess(this.comment);

  @override
  List<Object> get props => [comment];
}

class CommentDeleted extends CommentState {
  final String message;

  const CommentDeleted(this.message);

  @override
  List<Object> get props => [message];
}

class CommentOperationFailure extends CommentState {
  final String error;

  const CommentOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}
