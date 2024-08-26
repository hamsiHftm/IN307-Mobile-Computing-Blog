import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_card.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';
import 'package:in307_mobile_computing_blog/provider/blog_provider.dart';

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
    return ListView.builder(
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        return BlogCard(blog: blogs[index]);
      },
    );
  }
}