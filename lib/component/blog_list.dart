import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/blog_api.dart';
import '../model/blog.dart';
import '../provider/blog_provider.dart';
import '../screens/blog_detail_view.dart';
import 'blog_card.dart';

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
    return Consumer<BlogModel>(
      builder: (context, blogModel, child) {
        if (blogModel.blogs.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        final blogsToShow = favoritesOnly
            ? blogModel.blogs.where((blog) => blog.isFavorite).toList()
            : blogModel.blogs;

        return ListView.builder(
          itemCount: blogsToShow.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailView(
                      blogId: blogsToShow[index].id, // Pass only the ID
                    ),
                  ),
                );
              },
              child: BlogCard(
                blog: blogsToShow[index],
              ),
            );
          },
        );
      },
    );
  }
}