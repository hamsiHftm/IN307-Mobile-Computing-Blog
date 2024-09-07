import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_card_widget.dart';
import 'package:in307_mobile_computing_blog/component/loading_widget.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';
import 'package:in307_mobile_computing_blog/provider/blog_provider.dart';
import 'package:in307_mobile_computing_blog/screens/blog_info_view.dart';
import 'package:provider/provider.dart';

import '../screens/blog_detail_view.dart';

class BlogList extends StatelessWidget {
  // List of blogs to display
  final List<Blog> blogs;

  // Blog model to manage state
  final BlogModel blogModel;

  // Constructor with required parameters
  const BlogList({
    Key? key,
    required this.blogs,
    required this.blogModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen to changes in the BlogModel
    return Consumer<BlogModel>(
      builder: (context, blogModel, child) {
        // Show loading widget if there are no blogs
        if (blogModel.blogs.isEmpty) {
          return const LoadingWidget();
        }

        // Blogs to display
        final blogsToShow = blogModel.blogs;

        return Container(
          color: Theme.of(context).colorScheme.tertiary, // Background color
          child: ListView.builder(
            itemCount: blogsToShow.length, // Number of items in the list
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to the BlogDetailView when a blog item is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogDetailView(
                        blogId: blogsToShow[index].id, // Pass the blog ID to the detail view
                      ),
                    ),
                  );
                },
                child: BlogCardWidget(
                  blog: blogsToShow[index], // Display each blog in a card
                ),
              );
            },
          ),
        );
      },
    );
  }
}