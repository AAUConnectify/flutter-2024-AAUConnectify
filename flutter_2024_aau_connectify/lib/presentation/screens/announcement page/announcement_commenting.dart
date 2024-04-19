import 'package:flutter/material.dart';

class AnnouncementCommenting extends StatefulWidget {
  @override
  _AnnouncementCommentState createState() => _AnnouncementCommentState();
}

class _AnnouncementCommentState extends State<AnnouncementCommenting> {
  final List<String> _comments = [];

  void _addComment(String comment) {
    setState(() {
      _comments.add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Announcement content
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'This is the announcement post content.',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        // Comment section
        Expanded(
          child: ListView.builder(
            itemCount: _comments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_comments[index]),
              );
            },
          ),
        ),
        // Comment input field
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                  ),
                  onSubmitted: (comment) {
                    _addComment(comment);
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // Implement sending the comment here
                  // For simplicity, directly add the comment
                  _addComment('New Comment');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
