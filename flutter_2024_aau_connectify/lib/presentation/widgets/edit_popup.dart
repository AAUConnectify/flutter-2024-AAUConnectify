import 'package:flutter/material.dart';
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