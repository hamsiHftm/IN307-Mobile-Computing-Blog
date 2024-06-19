import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';
import 'package:intl/intl.dart';


class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.blog,
    required this.onFavoriteToggle,
  });

  final Blog blog;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blog.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            Text(blog.text),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat("dd.M.yyyy").format(blog.createdAt)),
                IconButton(
                  onPressed: onFavoriteToggle,
                  icon: Icon(
                    blog.isFavorite ? Icons.favorite : Icons.favorite_outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}