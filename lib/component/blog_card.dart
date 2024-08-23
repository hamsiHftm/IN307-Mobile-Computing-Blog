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
      elevation: 0, // Removes the shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!, width: 1), // Adds a border if needed
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
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    blog.picUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.grey[600],
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            else
              Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(
                    Icons.image,
                    color: Colors.grey[600],
                    size: 40,
                  ),
                ),
              ),
            const SizedBox(width: 16),
            // Right Column: Blog Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blog Title
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // User Info: Name and Profile Pic
                  Row(
                    children: [
                      // User Profile Picture
                      ClipOval(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: blog.user?.picUrl != null && blog.user!.picUrl!.isNotEmpty
                              ? Image.network(
                            blog.user!.picUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey[600],
                                    size: 20,
                                  ),
                                ),
                              );
                            },
                          )
                              : Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // User Name or Email
                      Expanded(
                        child: Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Blog Details: Likes and Creation Date (on the same line with a dot separator)
                  Row(
                    children: [
                      Text(
                        '${blog.numberOfLikes} Likes',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '•',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        createdDate,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
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