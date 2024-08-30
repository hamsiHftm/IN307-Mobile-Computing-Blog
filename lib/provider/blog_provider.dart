import 'package:flutter/material.dart';
import '../api/blog_api.dart';
import '../model/blog.dart';

class BlogModel extends ChangeNotifier {
  List<Blog> _blogs = [];
  int _offset = 0;
  final int _limit = 10;
  bool _isFetching = false;

  List<Blog> get blogs => _blogs;

  BlogModel() {
    // fetchBlogs(); // Fetch blogs when the model is created
  }

  Future<void> fetchBlogs({bool refresh = false}) async {
    if (_isFetching) return; // Prevent fetching while already fetching
    if (refresh) {
      _offset = 0;
    }
    _isFetching = true;

    try {
      final List<Blog> newBlogs = await BlogApi.instance.getBlogs(
        limit: _limit,
        offset: _offset,
      );

      if (refresh) {
        _blogs = newBlogs;
      } else {
        _blogs.addAll(newBlogs);
      }

      _offset += newBlogs.length;
      notifyListeners(); // Notify listeners that the data has changed
    } catch (e) {
      // Handle error, error message will be shown in the view
      print("Error fetching blogs: $e");
      throw e;
    } finally {
      _isFetching = false;
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