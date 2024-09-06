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
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _fetchBlogs();
  }

  Future<void> _fetchBlogs({bool refresh = false}) async {
    setState(() {
      _isLoading = true; // Set loading state to true while fetching data
    });

    try {
      await Provider.of<BlogModel>(context, listen: false).fetchBlogs(refresh: refresh);
    } catch (e) {
      setState(() {
        _errorMessage = 'Something went wrong. Cannot fetch blogs. Please try again later.';
      });
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state after fetching data
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _errorMessage = null; // Clear error message on refresh
    });
    await _fetchBlogs(refresh: true);
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
              onRetry: _refresh,
            );
          } else if (_isLoading) {
            // Show loading widget while fetching data
            return Center(child: LoadingWidget());
          } else if (blogModel.blogs.isEmpty) {
            // Show image if no blogs are available
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_comment.png'), // Image when no blogs are available
                  const SizedBox(height: 20), // Space between image and text
                  const Text(
                    'No blogs available.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                _fetchBlogs();
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