// lib/widgets/comment_card_widget.dart

import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/profile_icon_widget.dart';
import '../model/comment.dart'; // Adjust the import according to your file structure

class CommentCardWidget extends StatelessWidget {
  // The comment object to be displayed
  final Comment comment;

  // Constructor to initialize the widget with a Comment object
  const CommentCardWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card elevation to create a shadow effect
      elevation: 4.0,
      // Margin around the card
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        // Padding inside the card
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User profile picture
            ProfileIconWidget(
              picUrl: comment.user.picUrl,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User's name displayed in bold
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
                  // Comment metadata: number of likes
                  Row(
                    children: [
                      Icon(Icons.favorite, size: 16.0, color: Colors.white,),
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