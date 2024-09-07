// lib/widgets/comment_card_widget.dart

import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/profile_icon_widget.dart';
import '../model/comment.dart'; // Adjust the import according to your file structure

class CommentCardWidget extends StatelessWidget {
  final Comment comment;

  const CommentCardWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileIconWidget(
              picUrl: comment.user.picUrl,
            ),
            // User profile picture
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User's name
                  Text(
                    comment.user.getDisplayName(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  // Comment content
                  Text(
                    comment.content,
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 4.0),
                  // Comment metadata
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(
                        '${comment.numberOfLikes} Likes',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
