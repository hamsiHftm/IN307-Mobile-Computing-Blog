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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchBlogs();
    });
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

  void _clearFilter() {
    // Clear the search term and refresh the blog list
    _fetchBlogs(refresh: true);
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

          // Determine if the clear filter button should be shown
          final showClearFilterButton = blogModel.searchTerm.isNotEmpty;

          // Determine which content to display
          Widget content;
          if (blogModel.isFetching && blogModel.blogs.isEmpty) {
            content = Center(child: LoadingWidget());
          } else if (blogModel.blogs.isEmpty) {
            content = Center(
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
          } else {
            content = NotificationListener<ScrollNotification>(
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
          }

          // Build the final layout
          return Column(
            children: [
              if (showClearFilterButton) // Show the button only if the search term is not empty
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _clearFilter,
                    child: const Text("Clear Filter"),
                  ),
                ),
              Expanded(child: content),
            ],
          );
        },
      ),
    );
  }
}