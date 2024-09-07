import 'dart:math';

import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_list.dart';
import 'package:in307_mobile_computing_blog/component/loading_widget.dart';
import 'package:in307_mobile_computing_blog/provider/blog_provider.dart';
import 'package:provider/provider.dart';
import '../component/blog_error_widget.dart';
import '../model/user.dart';
import 'login_view.dart';
import '../provider/user_provider.dart';

class BlogListView extends StatefulWidget {
  final bool favoritesOnly;
  final bool showUserBlogsOnly;
  final User? user;

  const BlogListView({
    super.key,
    this.favoritesOnly = false,
    this.showUserBlogsOnly = false,
    this.user,
  });

  @override
  _BlogListViewState createState() => _BlogListViewState();
}

class _BlogListViewState extends State<BlogListView> {
  String? _errorMessage;
  int _currentPage = 1; // Track the current page
  final int _limit = 10; // Limit for blogs per page

  @override
  void initState() {
    super.initState();
    _fetchBlogs(); // Fetch the first page of blogs
  }

  Future<void> _fetchBlogs({bool refresh = false}) async {
    setState(() {
      _errorMessage = null;
    });

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final blogProvider = Provider.of<BlogModel>(context, listen: false);
      int? userId = (widget.showUserBlogsOnly && userProvider.isLoggedIn)
          ? userProvider.user?.id
          : null;

      await blogProvider.fetchBlogs(
        refresh: refresh,
        offset: _currentPage - 1,
        limit: _limit,
        userId: userId,
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Something went wrong. Cannot fetch blogs. Please try again later.';
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _currentPage = 1; // Reset to the first page on refresh
    });
    await _fetchBlogs(refresh: true);
  }

  Future<void> _nextPage() async {
    final blogProvider = Provider.of<BlogModel>(context, listen: false);
    if (_currentPage * _limit < blogProvider.totalBlogs) {
      setState(() {
        _currentPage += 1;
      });
      await _fetchBlogs();
    }
  }

  Future<void> _prevPage() async {
    if (_currentPage > 1) {
      setState(() {
        _currentPage -= 1;
      });
      await _fetchBlogs();
    }
  }

  void _clearFilter() {
    _fetchBlogs(refresh: true); // Clear any filters applied to the blog search
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Consumer<BlogModel>(
        builder: (context, blogModel, child) {
          Widget content;

          if (_errorMessage != null) {
            return BlogErrorWidget(
              message: _errorMessage!,
              onRetry: _refresh,
            );
          }

          if (widget.showUserBlogsOnly && !userProvider.isLoggedIn) {
            content = Center(
              child: ElevatedButton(
                onPressed: () async {
                  final loginSuccess = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );

                  if (loginSuccess == true) {
                    await _fetchBlogs(refresh: true);
                  }
                },
                child: const Text("Login to view your blogs"),
              ),
            );
          } else if (blogModel.isFetching && blogModel.blogs.isEmpty) {
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
              if (!(widget.showUserBlogsOnly && !userProvider.isLoggedIn))
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: _currentPage == 1 ? null : _prevPage,
                      ),
                      Text(
                        '${_currentPage} / ${max(1, (blogModel.totalBlogs / _limit).ceil())}',
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: (_currentPage * _limit >= blogModel.totalBlogs)
                            ? null
                            : _nextPage,
                      ),
                      if (blogModel.searchTerm.isNotEmpty)
                        ElevatedButton(
                          onPressed: _clearFilter,
                          child: const Text("Clear Filter"),
                        ),
                    ],
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