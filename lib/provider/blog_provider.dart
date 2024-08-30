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
    if (_isFetching || !_hasMoreBlogs) return; // Prevent fetching while already fetching or if no more blogs
    if (refresh) {
      _offset = 0;
      _hasMoreBlogs = true; // Reset when refreshing
    }
    _isFetching = true;

    try {
      final List<Blog> newBlogs = await BlogApi.instance.getBlogs(
        limit: _limit,
        offset: _offset,
        searchTitle: searchTitle,
        userId: userId,
        orderBy: orderBy,
        asc: asc,
      );

      if (refresh) {
        _blogs = newBlogs; // Replace current blogs with new data on refresh
      } else {
        _blogs.addAll(newBlogs); // Add new blogs to the existing list
      }

      if (newBlogs.length < _limit) {
        _hasMoreBlogs = false; // No more blogs available
      } else {
        _offset += newBlogs.length; // Update the offset for pagination
      }

      notifyListeners(); // Notify listeners that the data has changed
    } catch (e) {
      print("Error fetching blogs: $e");
      throw e;
    } finally {
      _isFetching = false; // Reset fetching state
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