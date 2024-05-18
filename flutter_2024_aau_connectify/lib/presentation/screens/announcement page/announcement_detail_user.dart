import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_2024_aau_connectify/Domain/comment_model.dart';
import 'package:flutter_2024_aau_connectify/application/announcement/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/application/comment/comment_bloc.dart';
import 'package:flutter_2024_aau_connectify/application/generalcubit/general_cubit.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/typography.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/announcement_description_card.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/announcement_detail_image_card.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/edit_popup.dart';

class AnnouncementDetailUser extends StatelessWidget {
  final String id;
  AnnouncementDetailUser({super.key, required this.id});
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CommentBloc>(context).add(FetchComments(id));
    return Scaffold(
      appBar: AppBar(
        title: const Text("post detail"),
        leading: IconButton(
          key: const Key('back_button_from_announcement_detail'),
            onPressed: () {

              context.go(homeRoute);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        children: [
          BlocBuilder<AnnouncementBloc, AnnouncementState>(
            builder: (context, state) {
              if (state is SingleAnnouncementLoaded) {
                final data = state.announcement;
                return Column(
                  children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: CustomPaddings.medium,
                            bottom: CustomPaddings.small,
                            left: CustomPaddings.small),
                        child: Text(
                          data.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: CustomFontSize.h3),
                        ),
                      ),
                      AnnouncementDetailImageCard(image: data.image),
                      AnnouncementDescriptionCard(
                        announcement: data,
                      ),
                    ]),
                  ],
                );
              }

              if (state is AnnouncementOperationFailure) {
                return Center(child: Text((state).error));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(CustomPaddings.medium),
              child: TextField(
                key: const Key('comment_field'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: commentController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  disabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(),
                  hintText: 'Add a comment...',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(CustomPaddings.extraLarge),
            child: BlocListener<CommentBloc, CommentState>(
              listener: (context, state) {
                if (state is CommentPosting) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comment post on progress...'),
                      duration: Duration(seconds: 2),
                      backgroundColor: CustomColors.textGrey,
                    ),
                  );
                }
                if (state is CommentUpdating){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comment updating...'),
                      duration: Duration(seconds: 2),
                      backgroundColor: CustomColors.textGrey,
                    ),
                  );
                }
                if (state is CommentUpdated) {
                  BlocProvider.of<CommentBloc>(context).add(FetchComments(id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comment updated successfully'),
                      duration: Duration(seconds: 2),
                      backgroundColor: CustomColors.primaryColor,
                    ),
                  );
                }

                if (state is CommentOperationSuccess) {
                  BlocProvider.of<CommentBloc>(context).add(FetchComments(id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comment posted successfully'),
                      duration: Duration(seconds: 2),
                      backgroundColor: CustomColors.primaryColor,
                    ),
                  );
                }
                if (state is CommentOperationFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text((state).error),
                      duration: const Duration(seconds: 2),
                      backgroundColor: CustomColors.errorColor,
                    ),
                  );
                }
                if (state is CommentDeleted) {
                  BlocProvider.of<CommentBloc>(context).add(FetchComments(id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comment deleted successfully'),
                      duration: Duration(seconds: 1),
                      backgroundColor: CustomColors.primaryColor,
                    ),
                  );
                }
                if (state is CommentDeleting) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comment deleting...'),
                      duration: Duration(seconds: 1),
                      backgroundColor: CustomColors.textGrey,
                    ),
                  );
                }
              },
              child: ElevatedButton(
                key: const Key('post_comment_button'),
                style: ButtonStyle(
                  alignment: Alignment.center,
                  textStyle: MaterialStatePropertyAll(
                      Theme.of(context).textTheme.titleLarge),
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(
                        horizontal: CustomPaddings.medium,
                        vertical: CustomPaddings.large),
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<CommentBloc>(context).add(
                    CreateComment(commentController.text, id),
                  );
                },
                child: const Text('Post Comment'),
              ),
            ),
          ),
          BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CommentPosting || state is CommentDeleting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CommentLoaded) {
                final List<Comment> commentsData = state.comments;
                if (commentsData.isEmpty) {
                  return Center(
                    child: Text(
                      'No comments found. Be the first to comment!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                }
                return Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1msyCD.img'),
                              ),
                              title: Text(commentsData[index].fullName),
                              subtitle: Text(commentsData[index].content),
                            ),
                            //Show edit and delete button only if the comment is made by the user
                            commentsData[index].userId !=
                                    context.watch<GeneralCubit>().userid
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        //edit button
                                        ElevatedButton(
                                          key: const Key('edit_comment_button'),
                                          onPressed: () {
                                            showCommentEdit(context,
                                                commentId:commentsData[index].id,
                                                announcementId: id,
                                                comment: commentsData[index].content);
                                          },
                                          child: const Text('Edit'),
                                        ),
                                        //delete button
                                        ElevatedButton(
                                          key: const Key('delete_comment_button'),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .error),
                                          ),
                                          onPressed: () {
                                            BlocProvider.of<CommentBloc>(
                                                    context)
                                                .add(DeleteComment(
                                                    commentsData[index].id));
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: commentsData.length,
                    ),
                    const SizedBox(height: 40)
                  ],
                );
              }
              return Center(
                  child: Column(
                children: [
                  const Text('Failed to load comments. please try again'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CommentBloc>(context)
                          .add(FetchComments(id));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ));
            },
          ),
        ],
      ),
    );
  }
}
