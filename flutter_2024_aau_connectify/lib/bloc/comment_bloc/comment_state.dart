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
  
}

class CommentDeleted extends CommentState {
  
}

class CommentOperationFailure extends CommentState {
  final String error;

  const CommentOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}


final class CommentPosting extends CommentState {}

