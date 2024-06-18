import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_2024_aau_connectify/application/comment/comment_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void showEditDialog(BuildContext context, {String fullName = "", String fieldOfStudy = "", String bio = "", String profilePicture = ""}) {
  final fullNameController = TextEditingController(text: fullName);
  final fieldOfStudyController = TextEditingController(text: fieldOfStudy);
  final bioController = TextEditingController(text: bio);
  final profilePictureController = TextEditingController(text: profilePicture);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: fieldOfStudyController,
                decoration: const InputDecoration(labelText: 'Field of Study'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: profilePictureController,
                decoration: const InputDecoration(labelText: 'Profile Picture URL'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.pop(); // Dismiss the dialog
            },
            child: const Text('Edit'),
          ),
        ],
      );
    },
  );
}

void showCommentEdit(BuildContext context, {String comment = "", required String announcementId,  required String commentId , }) {
  final commentController = TextEditingController(text: comment);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        title: const Text('Edit your comment'),
        content: SizedBox(
          height: 250, // Adjust the height of the dialog if needed
          width: 400, // Adjust the width as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200,
                child: TextField(
                  key: const Key('comment_edit_textfield'),
                  controller: commentController,
                  maxLines: null, // Allow multiple lines
                  expands: true, // Expand to fill the container
                  decoration: const InputDecoration(
                    labelText: 'Edit your comment',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          
          TextButton(
            onPressed: () {
            (context).pop();  
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            key: const Key('update_comment_button'),
            onPressed: () {
              BlocProvider.of<CommentBloc>(context).add(UpdateComment( commentId, commentController.text,  announcementId));
              context.pop(); // Dismiss the dialog
            },
            child: const Text('Update'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceAround,
      );
    },
  );
}


