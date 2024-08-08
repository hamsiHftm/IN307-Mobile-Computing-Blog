import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/screens/blog_form_view.dart';
import 'package:intl/intl.dart';

import '../model/blog.dart';
import '../provider/blog_provider.dart';

class BlogDetailView extends StatelessWidget {
  final Blog blog;
  final BlogModel blogModel;

  const BlogDetailView({super.key, required this.blog, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(blog.createdAt),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              blog.text,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to edit blog page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogFormView(
                      blog: blog,
                      onSave: ({required Blog newBlog, Blog? oldBlog}) {
                        int index = blogModel.getIndexOfBlog(oldBlog!);
                        blogModel.editBlog(index, newBlog);
                      },),
                  ),
                );
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
