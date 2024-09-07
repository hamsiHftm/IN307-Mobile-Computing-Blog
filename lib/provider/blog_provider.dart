import 'package:flutter/material.dart';
import '../api/blog_api.dart';
import '../model/blog.dart';
import 'dart:math';

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
    // fetchBlogs(); // Fetch blogs when the model is created
  }

  Future<void> fetchBlogs({
    bool refresh = false,
    bool nextPage = false,
    String searchTitle = '',
    int? userId,
    String orderBy = 'createdAt',
    bool asc = true,
    offset = 0,
    limit = 10
  }) async {
    if (_isFetching) return; // Prevent duplicate fetching

    // setting current search value
    _searchTerm = searchTitle;

    // If page is reloading, it should set the following
    if (refresh) {
      _blogs = []; // Clear the blog list before loading new data
      notifyListeners(); // Notify listeners to update UI immediately
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
      notifyListeners();
      // Handle error: throw exception or set an error message to show in the UI
      throw e; // This will be caught in _fetchBlogs method in BlogListView
    } finally {
      _isFetching = false; // Reset fetching state after the process is done
      notifyListeners(); // Notify listeners that fetching is complete
    }
  }

  int getIndexOfBlog(Blog blog) {
    return _blogs.indexOf(blog);
  }

  void addBlog(Blog newBlog) {
    _blogs.add(newBlog);
    notifyListeners(); // Notify listeners that the data has changed
  }

  void editBlog(int index, Blog editedBlog) {
    _blogs[index] = editedBlog;
    notifyListeners(); // Notify listeners that the data has changed
  }

  void toggleFavorite(int index) {
    _blogs[index].isFavorite = !_blogs[index].isFavorite;
    notifyListeners(); // Notify listeners that the data has changed
  }
}