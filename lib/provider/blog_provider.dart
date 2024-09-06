import 'package:flutter/material.dart';
import '../api/blog_api.dart';
import '../model/blog.dart';

class BlogModel extends ChangeNotifier {
  List<Blog> _blogs = [];
  int _offset = 0;
  final int _limit = 10;
  bool _isFetching = false;
  bool _hasMoreBlogs = true;

  List<Blog> get blogs => _blogs;
  bool get hasMoreBlogs => _hasMoreBlogs;
  bool get isFetching => _isFetching;

  BlogModel() {
    // fetchBlogs(); // Fetch blogs when the model is created
  }

  Future<void> fetchBlogs({
    bool refresh = false,
    String searchTitle = '',
    String? userId,
    String orderBy = 'createdAt',
    bool asc = true,
  }) async {
    if (refresh) {
      _blogs = []; // Clear the blog list before loading new data
      _offset = 0;
      _hasMoreBlogs = true;
      notifyListeners(); // Notify listeners to update UI immediately
    }

    if (_isFetching || !_hasMoreBlogs) return; // Prevent duplicate fetching
    _isFetching = true;
    notifyListeners(); // Notify UI that fetching has started

    try {
      final List<Blog> newBlogs = await BlogApi.instance.getBlogs(
        limit: _limit,
        offset: _offset,
        searchTitle: searchTitle,
        userId: userId,
        orderBy: orderBy,
        asc: asc,
      );

      _blogs.addAll(newBlogs);

      if (newBlogs.length < _limit) {
        _hasMoreBlogs = false; // No more blogs available
      } else {
        _offset += newBlogs.length; // Update offset for pagination
      }
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