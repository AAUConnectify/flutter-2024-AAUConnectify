import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_2024_aau_connectify/models/comment_model.dart';
import 'package:flutter_2024_aau_connectify/repository/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';


class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc({required this.commentRepository}) : super(CommentInitial()) {
    on<FetchComments>(_onFetchComments);
    on<CreateComment>(_onCreateComment);
    on<UpdateComment>(_onUpdateComment);
    on<DeleteComment>(_onDeleteComment);
    on<FetchCommentById>(_onFetchCommentById);
  }

  Future<void> _onFetchComments(FetchComments event, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    try {
      final response = await commentRepository.fetchComments(event.announcementId);
      print(response);
      if (response['success']) {
        emit(CommentLoaded(response['comment']));
      } else {
        emit(CommentOperationFailure(response['message']));
      }
    } catch (e) {
      emit(CommentOperationFailure(e.toString()));
    }
  }

  Future<void> _onCreateComment(CreateComment event, Emitter<CommentState> emit) async {
    emit(CommentPosting());
    try {
      final response = await commentRepository.createComment(event.content, event.announcementId);
      if (response['success']) {
        emit(CommentOperationSuccess());
      } else {
        emit(CommentOperationFailure(response['message']));
      }
    } catch (e) {
      emit(CommentOperationFailure(e.toString()));
    }
  }

  Future<void> _onUpdateComment(UpdateComment event, Emitter<CommentState> emit) async {
    emit(CommentUpdating());
    try {
      final response = await commentRepository.updateComment(event.commentId, event.content, event.announcementId);
      if (response['success']) {
        emit(CommentUpdated());
      } else {
        emit(CommentOperationFailure(response['message']));
      }
    } catch (e) {
      emit(CommentOperationFailure(e.toString()));
    }
  }

  Future<void> _onDeleteComment(DeleteComment event, Emitter<CommentState> emit) async {
    emit(CommentDeleting());
    try {
      final response = await commentRepository.deleteComment(event.commentId);
      if (response['success']) {
        emit(CommentDeleted());
      } else {
        emit(CommentOperationFailure(response['message']));
      }
    } catch (e) {
      emit(CommentOperationFailure(e.toString()));
    }
  }

  Future<void> _onFetchCommentById(FetchCommentById event, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    try {
      final response = await commentRepository.fetchCommentById(event.commentId);
      if (response['success']) {
        emit(CommentOperationSuccess());
      } else {
        emit(CommentOperationFailure(response['message']));
      }
    } catch (e) {
      emit(CommentOperationFailure(e.toString()));
    }
  }

  void onEvent(CommentEvent event) {
    print('$event is the event that was called');
    super.onEvent(event);
  }
}
