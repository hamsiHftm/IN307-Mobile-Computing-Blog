// lib/widgets/comment_list_widget.dart

import 'package:flutter/material.dart';
import '../model/comment.dart';  // Adjust the import according to your file structure
import 'comment_card_widget.dart';  // Adjust the import according to your file structure

class CommentListWidget extends StatelessWidget {
  final List<Comment> comments;

  const CommentListWidget({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return CommentCardWidget(comment: comment);
      },
    );
  }
}