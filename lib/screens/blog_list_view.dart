import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_list.dart';
import 'package:in307_mobile_computing_blog/component/loading_widget.dart';
import 'package:in307_mobile_computing_blog/provider/blog_provider.dart';
import 'package:provider/provider.dart';

import '../component/blog_error_widget.dart';

class BlogListView extends StatefulWidget {
  final bool favoritesOnly;

  const BlogListView({Key? key, this.favoritesOnly = false}) : super(key: key);

  @override
  _BlogListViewState createState() => _BlogListViewState();
}

class _BlogListViewState extends State<BlogListView> {
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchBlogs();
  }

  Future<void> _fetchBlogs({bool refresh = false}) async {
    setState(() {
      _errorMessage = null; // Clear any previous error message
    });

    try {
      await Provider.of<BlogModel>(context, listen: false).fetchBlogs(
        refresh: refresh, // If true, reset the blogs list
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Something went wrong. Cannot fetch blogs. Please try again later.';
      });
    }
  }

  Future<void> _refresh() async {
    await _fetchBlogs(refresh: true); // Refresh blog list
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Consumer<BlogModel>(
        builder: (context, blogModel, child) {
          if (_errorMessage != null) {
            return BlogErrorWidget(
              message: _errorMessage!,
              onRetry: _refresh, // Optionally retry on error
            );
          }

          if (blogModel.isFetching && blogModel.blogs.isEmpty) {
            // Show loading widget only if still fetching and no blogs to display
            return Center(child: LoadingWidget());
          }

          if (blogModel.blogs.isEmpty) {
            // No blogs and not fetching anymore means we show the "no blogs" image
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_comment.png'),
                  const SizedBox(height: 20),
                  const Text(
                    'No blogs available.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // If blogs are available, show the blog list
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                _fetchBlogs(); // Load more blogs when scrolling to the bottom
                return true;
              }
              return false;
            },
            child: BlogList(
              blogs: blogModel.blogs,
              blogModel: blogModel,
            ),
          );
        },
      ),
    );
  }
}