import 'package:flutter/cupertino.dart';
import '../api/blog_api.dart';
import '../model/blog.dart';


class BlogModel extends ChangeNotifier {
  List<Blog> _blogs = [];

  List<Blog> get blogs => _blogs;

  BlogModel() {
    fetchBlogs(); // Fetch blogs when the model is created
  }

  void toggleFavorite(int index) {
    _blogs[index].isFavorite = !_blogs[index].isFavorite;
    notifyListeners(); // Notify listeners that the data has changed
  }

  Future<void> fetchBlogs() async {
    try {
      _blogs = await BlogApi.instance.getBlogs();
      notifyListeners(); // Notify listeners that the data has changed
    } catch (e) {
      // Handle error
      print("Error fetching blogs: $e");
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

}