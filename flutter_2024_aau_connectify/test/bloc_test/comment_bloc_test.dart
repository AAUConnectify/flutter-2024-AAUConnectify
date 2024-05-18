import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_2024_aau_connectify/bloc/comment_bloc/comment_bloc.dart';
import 'package:flutter_2024_aau_connectify/models/comment_model.dart';
import 'package:flutter_2024_aau_connectify/repository/comment_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCommentRepo extends Mock implements CommentRepository {}

void main() {
  group('Comment Bloc Test', () {
    final commentRepoMock = MockCommentRepo();
    final List<Comment> comments = [
      Comment(
        id: '1',
        content: 'content',
        announcementId: 'announcementId',
        userId: 'userId',
        fullName: 'fullName',
      )
    ];
    final Map commentData = {'success': true, 'comment': comments};

    blocTest<CommentBloc, CommentState>(
      'Check the bloc when fetch comment is added',
      build: () => CommentBloc(commentRepository: commentRepoMock),
      setUp: () {
        when(() => commentRepoMock.fetchComments('1'))
            .thenAnswer((_) async => commentData);
      },
      act: (bloc) => bloc.add(const FetchComments('1')),
      expect: () => <CommentState>[
        CommentLoading(),
        CommentLoaded(comments),
      ],
    );
    blocTest<CommentBloc, CommentState>(
      'Check the bloc is returns error when fetch comment is added  and responce is not success',
      build: () => CommentBloc(commentRepository: commentRepoMock),
      setUp: () {
        when(() => commentRepoMock.fetchComments('1'))
            .thenAnswer((_) async => {'success': false, 'message': 'Error message'});
      },
      act: (bloc) => bloc.add(const FetchComments('1')),
      expect: () => <CommentState>[
        CommentLoading(),
        const CommentOperationFailure('Error message'),
      ],
    );

    blocTest<CommentBloc, CommentState>(
      'Check the bloc when create comment is added',
      build: () => CommentBloc(commentRepository: commentRepoMock),
      setUp: () {
         when(() => commentRepoMock.deleteComment('1'))
            .thenAnswer((_) async => {'success': true, 'message': 'Error message'});
      },
      act: (bloc) => bloc.add(const DeleteComment('1')),
      expect: () => <CommentState>[
        CommentLoading(),
        CommentDeleted(),
      ],
    );
    blocTest<CommentBloc, CommentState>(
      'checkes when delete comment is added and response is not success',
      build: () => CommentBloc(commentRepository: commentRepoMock),
      setUp: () {
         when(() => commentRepoMock.deleteComment('1'))
            .thenAnswer((_) async => {'success': false, 'message': 'Error message'});
      },
      act: (bloc) => bloc.add(const DeleteComment('1')),
      expect: () => <CommentState>[
        CommentLoading(),
        const CommentOperationFailure('Error message'),
      ],
    );
    blocTest<CommentBloc, CommentState>(
      'Check the bloc when a it\'s called for single comment',
      build: () => CommentBloc(commentRepository: commentRepoMock),
      setUp: () {
         when(() => commentRepoMock.fetchCommentById('1'))
            .thenAnswer((_) async => {'success': true, 'message': 'Error message'});
      },
      act: (bloc) => bloc.add(const FetchCommentById('1')),
      expect: () => <CommentState>[
        CommentLoading(),
        CommentOperationSuccess(),
      ],
    );

  });


}
