import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';
import 'package:in307_mobile_computing_blog/component/blog_card.dart';

import '../screens/blog_detail_view.dart';

class BlogListView extends StatelessWidget {
  final List<Blog> blogs;
  final bool favoritesOnly;
  final BlogModel blogModel;

  const BlogListView({
    super.key,
    required this.blogs,
    required this.blogModel,
    this.favoritesOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final blogsToShow = favoritesOnly
        ? blogs.where((blog) => blog.isFavorite).toList()
        : blogs;

    return ListView.builder(
      itemCount: blogsToShow.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlogDetailView(
                  blog: blogsToShow[index],
                  blogModel: blogModel,),
              ),
            );
          },
          child: BlogCard(
            blog: blogsToShow[index],
            onFavoriteToggle: () => blogModel.toggleFavorite(index),
          ),
        );
      },
    );
  }
}
