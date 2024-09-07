import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/profile_icon_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:in307_mobile_computing_blog/model/blog.dart';

class BlogCardWidget extends StatelessWidget {
  // Constructor requiring a Blog object
  const BlogCardWidget({
    super.key,
    required this.blog,
  });

  // Blog object to display
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    // Format the blog's creation date to a relative time format
    final createdDate = timeago.format(blog.createdAt);

    return Card(
      elevation: 0, // Remove shadow for a flat appearance
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Rounded corners for the card
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSurface, // Border color
          width: 1, // Border width
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margin around the card
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding inside the card
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children at the start of the row
          children: [
            // Left Column: Blog Picture
            if (blog.picUrl != null && blog.picUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(6), // Rounded corners for the image
                child: SizedBox(
                  width: 100, // Fixed width for the image
                  height: 100, // Fixed height for the image
                  child: Image.network(
                    blog.picUrl!,
                    fit: BoxFit.cover, // Scale image to cover the box
                    errorBuilder: (context, error, stackTrace) {
                      // Widget to display if there's an error loading the image
                      return Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 40, // Icon size
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            else
            // Placeholder for missing image
              Container(
                width: 100,
                height: 100,
                color: Theme.of(context).colorScheme.surface,
                child: Center(
                  child: Icon(
                    Icons.image,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 40, // Icon size
                  ),
                ),
              ),
            const SizedBox(width: 16), // Space between image and text
            // Right Column: Blog Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align children at the start of the column
                children: [
                  // Blog Title
                  Text(
                    blog.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                    overflow: TextOverflow.clip, // Clip text that overflows
                  ),
                  const SizedBox(height: 8), // Space between title and user info
                  // User Info: Name and Profile Pic
                  Row(
                    children: [
                      ProfileIconWidget(
                        picUrl: blog.user?.picUrl, // Profile picture
                      ),
                      const SizedBox(width: 8), // Space between avatar and text
                      Expanded(
                        child: Text(
                          blog.user!.getDisplayName(), // Display name of the user
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis, // Ellipsis for overflowing text
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), // Space between user info and blog details
                  // Blog Details: Likes and Creation Date
                  Row(
                    children: [
                      Text('${blog.numberOfLikes} Likes',
                          style: Theme.of(context).textTheme.labelSmall),
                      const SizedBox(width: 4), // Space between text items
                      Text('•', style: Theme.of(context).textTheme.labelSmall),
                      const SizedBox(width: 4), // Space between text items
                      Text(createdDate,
                          style: Theme.of(context).textTheme.labelSmall),
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