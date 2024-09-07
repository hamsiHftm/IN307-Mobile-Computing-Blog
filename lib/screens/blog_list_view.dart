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

  Future<void> _fetchBlogs({bool refresh = false, bool nextPage = false, customOffset = 0}) async {
    setState(() {
      _errorMessage = null; // Clear any previous error message
    });

    try {
      await Provider.of<BlogModel>(context, listen: false).fetchBlogs(
        refresh: refresh,
        offset: customOffset,
        nextPage: nextPage
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

  Future<void> _nextPage(currentOffset) async {
    await _fetchBlogs(nextPage: true, refresh: true, customOffset: currentOffset);
  }

  void _clearFilter() {
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

          final showClearFilterButton = blogModel.searchTerm.isNotEmpty;
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
            content = BlogList(
              blogs: blogModel.blogs,
              blogModel: blogModel,
            );
          }

          return Column(
            children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the row content
                      children: [
                        // Left Icon Button (Decrement offset)
                        IconButton(
                          icon: const Icon(Icons.arrow_left), // Use left arrow icon
                          onPressed: blogModel.offset == 0
                              ? null // Disable button if offset is 0
                              : () {
                            blogModel.setOffset(blogModel.offset - 1); // Decrement offset
                            _nextPage(blogModel.offset);// Fetch blogs with updated offset
                          },
                        ),

                        // Display the current offset value (as page number)
                        Text(blogModel.getCurrentPage()), // Display offset + 1 as a 1-based page number

                        // Right Icon Button (Increment offset)
                        IconButton(
                          icon: const Icon(Icons.arrow_right), // Use right arrow icon
                          onPressed: blogModel.getNumberOfPages() ==  (blogModel.offset + 1)
                              ? null // Disable button if offset is 0
                              : () {
                            blogModel.setOffset(blogModel.offset + 1); // Increment offset
                            _nextPage(blogModel.offset); // Fetch blogs with updated offset
                          },
                        ),

                        if (showClearFilterButton)
                        // Clear Filter Button
                        ElevatedButton(
                          onPressed: _clearFilter, // Clear the search filter
                          child: const Text("Clear Filter"),
                        ),
                      ],
                    )
                ),
              Expanded(child: content),
            ],
          );
        },
      ),
    );
  }
}