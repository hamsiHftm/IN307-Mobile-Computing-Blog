import 'package:flutter/material.dart';
import '../api/blog_api.dart';
import '../model/blog.dart';
import '../model/user.dart';

class BlogModel extends ChangeNotifier {
  List<Blog> _blogs = [];
  bool _isFetching = false;
  String _searchTerm = '';
  int _totalBlogs = 0;

  List<Blog> get blogs => _blogs;
  bool get isFetching => _isFetching;
  String get searchTerm => _searchTerm;
  int get totalBlogs => _totalBlogs;

  BlogModel() {
    // Fetch blogs when the model is created if needed
  }

  Future<void> fetchBlogs({
    bool refresh = false,
    bool nextPage = false,
    String searchTitle = '',
    int? userId,
    String orderBy = 'createdAt',
    bool asc = true,
    int offset = 0,
    int limit = 10,
  }) async {
    if (_isFetching) return; // Prevent duplicate fetching

    _searchTerm = searchTitle;

    if (refresh) {
      _blogs = []; // Clear the blog list before loading new data
      notifyListeners(); // Notify UI to update immediately
    }

    _isFetching = true;
    notifyListeners(); // Notify UI that fetching has started

    try {
      final BlogResponse blogResponse = await BlogApi.instance.getBlogs(
        limit: limit,
        offset: offset,
        searchTitle: searchTitle,
        userId: userId,
        orderBy: orderBy,
        asc: asc,
      );

      _totalBlogs = blogResponse.totalBlogs;
      _blogs = blogResponse.blogs;
    } catch (e) {
      throw e; // Handle errors in the UI
    } finally {
      _isFetching = false; // Reset fetching state
      notifyListeners(); // Notify UI that fetching is complete
    }
  }

  Future<void> addBlog({
    required String title,
    required String content,
    required User user,
    String picUrl = '',
  }) async {
    if (_isFetching) return; // Prevent adding blog while fetching

    _isFetching = true;
    notifyListeners(); // Notify UI that fetching has started

    try {
      final Blog addedBlog = await BlogApi.instance.addBlog(
        title: title,
        content: content,
        userId: user.id,
        picUrl: picUrl,
      );

      _blogs.add(addedBlog);
      _totalBlogs += 1; // Increment the total count
      notifyListeners(); // Notify UI that data has changed
    } catch (e) {
      throw e; // Handle errors in the UI
    } finally {
      _isFetching = false;
      notifyListeners(); // Notify UI that fetching is complete
    }
  }
}