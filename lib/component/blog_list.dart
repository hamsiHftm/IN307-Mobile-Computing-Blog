import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_card_widget.dart';
import 'package:in307_mobile_computing_blog/component/loading_widget.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';
import 'package:in307_mobile_computing_blog/provider/blog_provider.dart';
import 'package:in307_mobile_computing_blog/screens/blog_info_view.dart';
import 'package:provider/provider.dart';

import '../screens/blog_detail_view.dart';

class BlogList extends StatelessWidget {
  final List<Blog> blogs;
  final BlogModel blogModel;

  const BlogList({
    Key? key,
    required this.blogs,
    required this.blogModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogModel>(
      builder: (context, blogModel, child) {
        if (blogModel.blogs.isEmpty) {
          return const LoadingWidget();
        }

        final blogsToShow = blogModel.blogs;

        return Container(
          color: Theme.of(context).colorScheme.tertiary,
          child: ListView.builder(
            itemCount: blogsToShow.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogDetailView(
                        blogId: blogsToShow[index].id,
                      ),
                    ),
                  );
                },
                child: BlogCardWidget(
                  blog: blogsToShow[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}