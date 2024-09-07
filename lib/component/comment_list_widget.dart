// lib/widgets/comment_list_widget.dart

import 'package:flutter/material.dart';
import '../model/comment.dart'; // Adjust the import according to your file structure
import 'comment_card_widget.dart'; // Adjust the import according to your file structure

class CommentListWidget extends StatelessWidget {
  // List of comments to display
  final List<Comment> comments;

  // Constructor to initialize the widget with a list of comments
  const CommentListWidget({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Shrink the list view to fit the height of its content
      shrinkWrap: true,
      // Disable scrolling on the list view, allowing the parent widget to handle scrolling
      physics: NeverScrollableScrollPhysics(),
      // Number of items in the list view
      itemCount: comments.length,
      // Builder to create each item in the list
      itemBuilder: (context, index) {
        // Get the comment at the current index
        final comment = comments[index];
        // Return a CommentCardWidget for each comment
        return CommentCardWidget(comment: comment);
      },
    );
  }
}