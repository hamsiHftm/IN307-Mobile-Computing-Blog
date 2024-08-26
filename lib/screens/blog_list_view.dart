import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_list.dart';
import 'package:in307_mobile_computing_blog/component/blog_error_widget.dart'; // Import the BlogErrorWidget
import 'package:in307_mobile_computing_blog/provider/blog_provider.dart';
import 'package:provider/provider.dart';

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
    try {
      await Provider.of<BlogModel>(context, listen: false).fetchBlogs(refresh: refresh);
    } catch (e) {
      setState(() {
        _errorMessage = 'Something went wrong. Cannot fetch blogs. Please try again later.';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Consumer<BlogModel>(
          builder: (context, blogModel, child) {
            if (_errorMessage != null) {
              return BlogErrorWidget(
                message: _errorMessage!,
                onRetry: _refresh,
              );
            } else if (blogModel.blogs.isEmpty) {
              return Center(child: CircularProgressIndicator());
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
      ),
    );
  }
}