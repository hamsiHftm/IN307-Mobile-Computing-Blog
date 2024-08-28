import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:in307_mobile_computing_blog/model/blog.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.blog,
  });

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    // User's display name logic
    final userName = (blog.user?.firstname?.isNotEmpty == true && blog.user?.lastname?.isNotEmpty == true)
        ? '${blog.user!.firstname} ${blog.user!.lastname}'
        : blog.user?.email ?? 'Unknown user';

    // Format the relative creation date
    final createdDate = timeago.format(blog.createdAt);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Blog Picture
            if (blog.picUrl != null && blog.picUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    blog.picUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            else
              // pic place holder
              Container(
                width: 100,
                height: 100,
                color: Theme.of(context).colorScheme.surface,
                child: Center(
                  child: Icon(
                    Icons.image,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 40,
                  ),
                ),
              ),
            const SizedBox(width: 16), // space between blog image and blog details
            // Right Column: Blog Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blog Title
                  Text(
                    blog.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(height: 8), // space between row
                  // User Info: Name and Profile Pic
                  Row(
                    children: [
                      // Conditionally use CircleAvatar for images, if pic not retrieved or available, display icon
                      blog.user?.picUrl != null && blog.user!.picUrl!.isNotEmpty
                          ? CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(blog.user!.picUrl!),
                      )
                          : Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person_2_outlined,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8), // Spacing between the avatar and the text
                      Expanded(
                        child: Text(
                          userName,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), // space between row
                  // Blog Details: Likes and Creation Date (on the same line with a dot separator)
                  Row(
                    children: [
                      Text(
                        '${blog.numberOfLikes} Likes',
                          style: Theme.of(context).textTheme.bodySmall
                      ),
                      const SizedBox(width: 4), // Spacing between the text
                      Text(
                        '•', style: Theme.of(context).textTheme.bodySmall
                      ),
                      const SizedBox(width: 4), // Spacing between the text
                      Text(
                        createdDate,
                        style: Theme.of(context).textTheme.bodySmall
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